// Copyright (C) 2024 John Donoghue <john.donoghue@ieee.org>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, see <http://www.gnu.org/licenses/>.

#include <iostream>
#include <sstream>
#include <ctype.h>
#include <cmath>
#include <octave/oct.h>
#include <octave/version.h>
#include <octave/defun-dld.h>

#include "octave/ov-struct.h"

#ifdef HAVE_CONFIG_H
#  include "./config.h"
#endif

#ifdef HAVE_OCTAVE_INTERPRETER_H
# include <octave/interpreter.h>
#endif

//#include "octave_odbc.h"

#ifdef HAVE_WINDOWS_H
  #define WIN32_LEAN_AND_MEAN
  #include <windows.h>
#endif
#include <sql.h>
#include <sqlext.h>

//--------------------------------------------------------------------

class octave_odbc : public OCTAVE_BASE_CLASS
{
public:
  /**
   * default constructor 
   */
  octave_odbc ();

  /**
   * create object
   */
  octave_odbc (const std::string &filename, const std::string &mode);

  /**
   * deconstructor
   */
  ~octave_odbc (void);

  // interface functions
  bool create (const std::string &filename, const std::string &username, const std::string &password, int flags, unsigned int to);
  void close (void);
  bool is_open() const;
  bool run (const std::string &query, octave_value &v);
  bool rollback ();
  bool commit ();
  bool find (const std::string &filter, octave_value &v);
  std::string getMessage() const;

  /**
   * Various properties of the octave_base_value datatype.
   */
  bool is_constant (void) const { return true;}
  bool is_defined (void) const { return true;}
  bool is_object (void) const { return true; }

  // required to use subsasn
  //string_vector map_keys (void) const { return fieldnames; }
  dim_vector dims (void) const { static dim_vector dv(1, 1); return dv; }

  octave_base_value * clone (void) const;
  octave_base_value * empty_clone (void) const;
  octave_base_value * unique_clone (void);

 /**
  * Overloaded methods to print
  */
  void print (std::ostream& os, bool pr_as_read_syntax = false) const;
  void print (std::ostream& os, bool pr_as_read_syntax = false); 
  void print_raw (std::ostream& os, bool pr_as_read_syntax) const;

 /**
  * overloaded methods to get properties
  */
  octave_value_list subsref (const std::string& type, const std::list<octave_value_list>& idx, int nargout);

  octave_value subsref (const std::string& type, const std::list<octave_value_list>& idx)
  {
    octave_value_list retval = subsref (type, idx, 1);
    return (retval.length () > 0 ? retval(0) : octave_value ());
  }

  octave_value subsasgn (const std::string& type, const std::list<octave_value_list>& idx, const octave_value& rhs);

private:
  octave_odbc (const octave_odbc &);

  SQLHENV env;
  SQLHDBC dbc;

  std::string readonly;
  std::string autocommit;
  unsigned int timeout;

  std::string db_name;
  std::string db_ver;
  std::string db_driver_name;
  std::string db_driver_ver;

  std::string message;

//  string_vector fieldnames;
#ifdef DECLARE_OCTAVE_ALLOCATOR
  DECLARE_OCTAVE_ALLOCATOR
#endif
  DECLARE_OV_TYPEID_FUNCTIONS_AND_DATA
};

#ifdef DEFINE_OCTAVE_ALLOCATOR 
DEFINE_OCTAVE_ALLOCATOR (octave_odbc);
#endif
DEFINE_OV_TYPEID_FUNCTIONS_AND_DATA (octave_odbc, "octave_odbc", "octave_odbc");

octave_odbc::octave_odbc ()
{
  dbc = SQL_NULL_HENV;
  env = SQL_NULL_HENV;
}

octave_odbc::octave_odbc (const octave_odbc &s)
{
  // should never be called
}

octave_odbc::~octave_odbc(void)
{
  close ();
}

octave_base_value *
octave_odbc::empty_clone (void) const 
{
  return new octave_odbc();
}

octave_base_value *
octave_odbc::clone (void) const 
{
  return new octave_odbc (*this);
}

octave_base_value *
octave_odbc::unique_clone (void) 
{
  OV_COUNT++;
  return this;
}

void
octave_odbc::print (std::ostream& os, bool pr_as_read_syntax) const
{
  print_raw (os, pr_as_read_syntax);
  newline (os);
}

void
octave_odbc::print (std::ostream& os, bool pr_as_read_syntax)
{
  print_raw (os, pr_as_read_syntax);
  newline (os);
}

void
octave_odbc::print_raw (std::ostream& os, bool pr_as_read_syntax) const
{
  os << "  Database with Properties:"; newline(os);
  os << "                  AutoCommit: " << autocommit; newline(os);
  os << "                    ReadOnly: " << readonly; newline(os);
  os << "                LoginTimeout: " << timeout; newline(os);
  os << "  Database and Driver Information:"; newline(os);
  os << "         DatabaseProductName: " << db_name; newline(os);
  os << "      DatabaseProductVersion: " << db_ver; newline(os);
  os << "                  DriverName: " << db_driver_name; newline(os);
  os << "               DriverVersion: " << db_driver_ver; newline(os);
}

octave_value_list
octave_odbc::subsref (const std::string& type, const std::list<octave_value_list>& idx, int nargout)
{
  octave_value_list retval;
  int skip = 1;

  switch (type[0])
    {
    default:
      error ("octave_odbc object cannot be indexed with %c", type[0]);
      break;
    case '.':
      {
        std::string prop = (idx.front ()) (0).string_value();
	if (prop == "Database")
	  retval(0) = db_name;
	else if (prop == "IsOpen")
	  retval(0) = octave_value(is_open());
	else if (prop == "Message")
	  retval(0) = octave_value(getMessage());
	else if (prop == "ReadOnly")
	  retval(0) = readonly;
	else if (prop == "AutoCommit")
	  retval(0) = autocommit;
	else if (prop == "LoginTimeout")
	  retval(0) = octave_value(timeout);
	else
	  error ("Unkown property '%s'", prop.c_str());
      }
      break;
    }

  if (idx.size () > 1 && type.length () > 1)
    retval = retval (0).next_subsref (nargout, type, idx, skip);

  return retval;
}

octave_value
octave_odbc::subsasgn (const std::string& type, const std::list<octave_value_list>& idx, const octave_value& rhs)
{
  octave_value retval;

  switch (type[0])
    {
    default:
      error ("octave_odbc object cannot be indexed with %c", type[0]);
      break;

    // Only AutoCommit property isnt readonly
    case '.':
      if (type.length () == 1)
        {
          octave_value prop = (idx.front ()) (0);
	  if (!prop.is_string() || prop.string_value() != "AutoCommit")
	    {
              error ("octave_odbc Unknown property");
	    }
          else if(!rhs.is_string() || (rhs.string_value() != "on" && rhs.string_value() != "off"))
            {
              error ("Expected AutoCommit as 'on' or 'off'");
            }
	  else
            {
              std::string  newautocommit = rhs.string_value();
              if (newautocommit != autocommit)
                {
                  SQLRETURN rc;
                  if (newautocommit == "off")
                      rc = SQLSetConnectAttr(dbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER)SQL_AUTOCOMMIT_OFF, 0);
		  else
                     rc = SQLSetConnectAttr(dbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER)SQL_AUTOCOMMIT_ON, 0);

		  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_SUCCESS)
                    autocommit = newautocommit;
                }
            }
            OV_COUNT++;
            retval = octave_value (this);
        }
      else
        {
          error ("octave_odbc invalid index");
        }
    }
  return retval;
}

bool
octave_odbc::create (const std::string &dbname, const std::string &username, const std::string &password, int flags, unsigned int to)
{
  SQLRETURN rc;

  autocommit = "off";
  readonly = "off";
  timeout = to;

  // Environment
  rc = SQLAllocHandle( SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);

  if(rc == SQL_ERROR)
    {
      message = "Error allocating env handle.";
      return false;
    }

  // ODBC: Version: Set
  rc = SQLSetEnvAttr( env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);

  // DBC: Allocate
  rc = SQLAllocHandle( SQL_HANDLE_DBC, env, &dbc);

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_DBC, dbc, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  //printf("msg: %lu %s '%s'\n", (unsigned long)NativeError, SqlState, (char*)Msg); 
	  i++;

	  message = (char*)Msg;
	}
    }

  if(! (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO))
    {
      SQLFreeHandle( SQL_HANDLE_ENV, env ); 
      return false;
    }

  if (timeout > 0)
    {
#if (SIZEOF_LONG_INT == 8)
      SQLPOINTER tm = (SQLPOINTER)((long)timeout);
#else
      SQLPOINTER tm = (SQLPOINTER)((long long)timeout);
#endif
      rc = SQLSetConnectAttr(dbc, SQL_LOGIN_TIMEOUT, (SQLPOINTER)tm, 0);
    }

  SQLUINTEGER commit = SQL_AUTOCOMMIT_OFF;
  if (flags & 2)
    {
      commit = SQL_AUTOCOMMIT_ON;
    }
  else
    {
      rc = SQLSetConnectAttr(dbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER)SQL_AUTOCOMMIT_OFF, 0);
    }

  SQLUINTEGER access = SQL_MODE_READ_WRITE;
  if (flags & 1)
    {
      access = SQL_MODE_READ_ONLY;
    
      rc = SQLSetConnectAttr(dbc, SQL_ATTR_ACCESS_MODE, (SQLPOINTER)SQL_MODE_READ_ONLY, 0);
    }
  else
    {
      rc = SQLSetConnectAttr(dbc, SQL_ATTR_ACCESS_MODE, (SQLPOINTER)SQL_MODE_READ_WRITE, 0);
    }

  // connection string
  if (dbname.find('=') != std::string::npos)
    {
      SQLCHAR outname[1024];
      SQLSMALLINT outlen;

      rc = SQLDriverConnect( dbc, NULL, (SQLCHAR*) dbname.c_str(), dbname.length(), outname, sizeof(outname), &outlen, SQL_DRIVER_NOPROMPT);
    }
  else
    {
      // DBC: Connect
      rc = SQLConnect( dbc, (SQLCHAR*) dbname.c_str(), SQL_NTS,
        (SQLCHAR*) username.c_str(), SQL_NTS,
        (SQLCHAR*) password.c_str(), SQL_NTS);
    }

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_DBC, dbc, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  //printf("msg: %lu %s '%s'\n", (unsigned long)NativeError, SqlState, (char*)Msg); 
	  i++;

	  message = (char*)Msg;
	}
    }

  if(! (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO))
    {
      close();
      return false;
    }

  // call SQLGetInfo to get driver info

  SQLCHAR szName[256];
  SQLSMALLINT cbName;

  //rc = SQLGetInfo(dbc, SQL_DATA_SOURCE_NAME, szName, sizeof(szName), &cbName);
  //printf("DS %s\n", (char*)szName);

  rc = SQLGetInfo(dbc, SQL_DRIVER_NAME, szName, sizeof(szName), &cbName);
  //printf("DN %s\n", (char*)szName);
  db_driver_name = (char*)szName;

  //rc = SQLGetInfo(dbc, SQL_DRIVER_ODBC_VER, szName, sizeof(szName), &cbName);

  rc = SQLGetInfo(dbc, SQL_DRIVER_VER, szName, sizeof(szName), &cbName);
  db_driver_ver = (char*)szName;

  //rc = SQLGetInfo(dbc, SQL_DATABASE_NAME, szName, sizeof(szName), &cbName);
  //printf("DBN %s\n", (char*)szName);

  rc = SQLGetInfo(dbc, SQL_DBMS_VER, szName, sizeof(szName), &cbName);
  db_ver = (char*)szName;

  rc = SQLGetInfo(dbc, SQL_DBMS_NAME, szName, sizeof(szName), &cbName);
  //printf("DB %s\n", (char*)szName);
  db_name = (char *)szName;

  SQLINTEGER sz;
  rc = SQLGetConnectAttr(dbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER)&commit, SQL_IS_INTEGER, &sz);
  if (commit == SQL_AUTOCOMMIT_ON)
    autocommit = "on";
  else
    autocommit = "off";

  rc = SQLGetConnectAttr(dbc, SQL_ATTR_ACCESS_MODE, (SQLPOINTER)&access, SQL_IS_INTEGER, &sz);
  if (access == SQL_MODE_READ_ONLY)
    readonly = "on";
  else
    readonly = "off";

  SQLINTEGER tmv;
  rc = SQLGetConnectAttr(dbc, SQL_LOGIN_TIMEOUT, (SQLPOINTER)&tmv, SQL_IS_INTEGER, &sz);
  timeout = tmv;

  return true;
}

void
octave_odbc::close (void)
{
  if (dbc != SQL_NULL_HENV)
    {
      SQLDisconnect( dbc );
      SQLFreeHandle( SQL_HANDLE_DBC, dbc );
      SQLFreeHandle( SQL_HANDLE_ENV, env ); 
      dbc = SQL_NULL_HENV;
    }
}

bool
octave_odbc::is_open () const
{
  if (dbc)
    return true;
  else
    return false;
}

bool
octave_odbc::find (const std::string &infilter, octave_value &v)
{
  v = Cell();

  SQLRETURN rc;
  SQLHSTMT hstmt;  

  SQLCHAR filter[1024];
  if (infilter == "")
    strcpy((char*)filter, "%");
  else
    strcpy((char*)filter, infilter.c_str());

  rc = SQLAllocHandle(SQL_HANDLE_STMT, dbc, &hstmt);  

  rc = SQLTables(hstmt,
    NULL, 0,
    NULL, 0,
    (SQLCHAR*)filter, SQL_NTS,
    NULL, 0
  );

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_STMT, hstmt, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  i++;
	  message = (char*)Msg;
	}
    }

  if (rc == SQL_ERROR)
    {
      SQLFreeHandle( SQL_HANDLE_STMT, hstmt);
      return false;
    }

  SQLSMALLINT cols = 0;
  rc = SQLNumResultCols(hstmt, &cols);

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_STMT, hstmt, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  i++;
	  message = (char*)Msg;
	}
    }

  if (rc == SQL_ERROR)
    {
      SQLFreeHandle( SQL_HANDLE_STMT, hstmt);
      return false;
    }

  if (cols != 0)
    {
      octave_map om;
      Cell coldata[cols];
      SQLSMALLINT col_type[cols];
      std::string col_name[cols];

      // TODO: we could probally just use the SQLColumns function and instead of SQLTables first
      // and combine data since it will be sortedby table

      // we only want 4 known columns that are at fixed indexes
      cols = 4;
      col_name[0] = "Catalog";
      col_type[0] = SQL_C_CHAR;
      col_name[1] = "Schema";
      col_type[1] = SQL_C_CHAR;
      col_name[2] = "Table";
      col_type[2] = SQL_C_CHAR;
      col_name[3] = "Type";
      col_type[3] = SQL_C_CHAR;

      // get rows
      octave_idx_type row = 0;
      while((rc = SQLFetch(hstmt)) == SQL_SUCCESS_WITH_INFO || rc == SQL_SUCCESS)
        {
          octave_value value;

          for (SQLSMALLINT c =1; c <= cols; c++)
            {
              SQLCHAR      szName[256];
              SQLLEN  cbName;
	      szName[0] = 0;
              rc = SQLGetData(hstmt, c, SQL_C_CHAR, szName, sizeof(szName), &cbName);  
              value = octave_value((char *)szName);

              if (coldata[c-1].numel() <= row)
                {
                  coldata[c-1].resize(dim_vector(row+20, 1));
                }

              coldata[c-1](row) = value;
	    }

          row++;
        }
  
      SQLCloseCursor(hstmt);

      // what was/would have been the 5th on (COmment, we replace here)
      col_name[4] = "Columns";
      coldata[4] = Cell(dim_vector(row, 1));
      cols++;

      for(octave_idx_type r = 0; r < row; r++)
        {
          // now get the column data
	  std::string catalog = coldata[0](r).string_value();
	  std::string schema = coldata[1](r).string_value();
	  std::string table = coldata[2](r).string_value();
	  std::list<std::string> columns; 
          rc = SQLColumns(hstmt,
            (SQLCHAR*)catalog.c_str(), catalog.length(),
	    (SQLCHAR*)schema.c_str(), schema.length(),
	    (SQLCHAR*)table.c_str(), table.length(), // SQL_NTS
	    NULL, 0
          );
	  SQLCHAR column_name[1024+1];
	  SQLLEN column_size;
          SQLBindCol(hstmt, 4, SQL_C_CHAR, column_name, 1024, &column_size);

          while (rc == SQL_SUCCESS)
            {
              column_name[0] = 0;
              rc = SQLFetch(hstmt);  
              if(column_name[0])
                columns.push_back((char*)column_name);
            }
      
          SQLCloseCursor(hstmt);

          coldata[4](r) = Cell(columns);
        }

      // set the data struct
      for (SQLSMALLINT c =1; c <= cols; c++)
        {
          coldata[c-1].resize(dim_vector(row, 1));
          om.assign(col_name[c-1], octave_value(coldata[c-1]));
        }

      v = om;
    }
  else
    SQLCloseCursor(hstmt);

  return true;
}

bool
octave_odbc::run (const std::string &query, octave_value &v)
{
  v = Cell();

  SQLRETURN rc;
  SQLHSTMT hstmt;  

  rc = SQLAllocHandle(SQL_HANDLE_STMT, dbc, &hstmt);  

  unsigned int statement_size = query.length();
  SQLCHAR SQLStatement[statement_size+1];
  strcpy((char *)SQLStatement, query.c_str());

  // Execute the statement.
  rc = SQLExecDirect(hstmt, SQLStatement, SQL_NTS);

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_STMT, hstmt, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  i++;
	  message = (char*)Msg;
	}
    }

  if (rc == SQL_ERROR)
    {
      SQLFreeHandle( SQL_HANDLE_STMT, hstmt);
      return false;
    }

  SQLSMALLINT cols = 0;
  rc = SQLNumResultCols(hstmt, &cols);

  if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
    {
      SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
      SQLINTEGER    NativeError;
      SQLSMALLINT   i, MsgLen;
      SQLRETURN     rc2;

      i = 1;
      while ((rc2 = SQLGetDiagRec(SQL_HANDLE_STMT, hstmt, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
        {
	  i++;
	  message = (char*)Msg;
	}
    }

  if (rc == SQL_ERROR)
    {
      SQLFreeHandle( SQL_HANDLE_STMT, hstmt);
      return false;
    }

  if (cols != 0)
    {
      octave_map om;
      Cell coldata[cols];
      SQLSMALLINT col_type[cols];
      std::string col_name[cols];

      for (SQLSMALLINT c =1; c <= cols; c++)
        {
	  SQLCHAR colname[256];
	  SQLSMALLINT colnamelen;
	  SQLULEN colsize;
	  SQLSMALLINT datatype;
	  SQLSMALLINT decimals, nullable;

          rc = SQLDescribeCol(  
            hstmt, c,
            colname, sizeof(colname), &colnamelen,
            &datatype, &colsize,
            &decimals, &nullable);

          //printf("%d col %d: '%s' [%d] t=%d d=%d n=%d\n", (int)rc, (int)c, (char*)colname, (int)colsize, (int)datatype, (int)decimals, (int)nullable);
          col_name[c-1] = (char *)colname;
          col_type[c-1] = datatype;

        }

      // get rows
      octave_idx_type row = 0;
      while((rc = SQLFetch(hstmt)) == SQL_SUCCESS_WITH_INFO || rc == SQL_SUCCESS)
        {
          octave_value value;

          for (SQLSMALLINT c =1; c <= cols; c++)
            {
              if (col_type[c-1] == SQL_INTEGER || col_type[c-1] == SQL_TINYINT || col_type[c-1] == SQL_BIGINT)
                {
                  int64_t data;
                  SQLLEN  cbName;
                  rc = SQLGetData(hstmt, c, SQL_C_SBIGINT, &data, sizeof(data), &cbName);  
                  value = octave_value(data);
                }
              else if (col_type[c-1] == SQL_REAL || col_type[c-1] == SQL_FLOAT || col_type[c-1] == SQL_DOUBLE)
                {
                  double data;
                  SQLLEN  cbName;
                  rc = SQLGetData(hstmt, c, SQL_C_DOUBLE, &data, sizeof(data), &cbName);  
                  value = octave_value(data);
                }
              else if (col_type[c-1] == SQL_BIT)
                {
	          char unsigned data;
                  SQLLEN  cbName;
                  rc = SQLGetData(hstmt, c, SQL_C_BIT, &data, sizeof(data), &cbName);  
                  value = octave_value(data==1 ? true : false);
                }
              else
                {
                  SQLCHAR szName[1024];
                  SQLLEN  cbName;
	          szName[0] = 0;
                  rc = SQLGetData(hstmt, c, SQL_C_CHAR, szName, sizeof(szName), &cbName);  
                  value = octave_value((char *)szName);
                }

              if (coldata[c-1].numel() <= row)
                {
                  coldata[c-1].resize(dim_vector(row+20, 1));
                }
              coldata[c-1](row) = value;
            }

          row++;
        }
    
      // set the data
      for (SQLSMALLINT c =1; c <= cols; c++)
        {
          coldata[c-1].resize(dim_vector(row, 1));
          om.assign(col_name[c-1], octave_value(coldata[c-1]));
        }
      v = om;
    }

  SQLCloseCursor(hstmt);

  return true;
}

bool
octave_odbc::rollback (void)
{
  bool ok = true;
  if (dbc)
    {
      SQLRETURN rc = SQLEndTran(SQL_HANDLE_DBC, dbc, SQL_ROLLBACK);
      if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
        {
          SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
          SQLINTEGER    NativeError;
          SQLSMALLINT   i, MsgLen;
          SQLRETURN     rc2;

          if (rc == SQL_ERROR)
            ok = false;

          i = 1;
          while ((rc2 = SQLGetDiagRec(SQL_HANDLE_DBC, dbc, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
           {
             i++;
	     message = (char*)Msg;
	   }
        }
    }
  return ok;
}

bool
octave_odbc::commit (void)
{
  bool ok = true;
  if (dbc)
    {
      SQLRETURN rc = SQLEndTran(SQL_HANDLE_DBC, dbc, SQL_COMMIT);
      if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
        {
          SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
          SQLINTEGER    NativeError;
          SQLSMALLINT   i, MsgLen;
          SQLRETURN     rc2;

          if (rc == SQL_ERROR)
            ok = false;

          i = 1;
          while ((rc2 = SQLGetDiagRec(SQL_HANDLE_DBC, dbc, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
           {
             i++;
	     message = (char*)Msg;
	   }
        }
    }
  return ok;
}

std::string
octave_odbc::getMessage() const
{
  return message;
}

static bool type_loaded = false;

void
init_types(void)
{
  if (!type_loaded)
    {
     octave_odbc::register_type ();
     type_loaded = true;
    }
}

// PKG_ADD: autoload ("__odbc_pkg_lock__", "__octave_odbc__.oct");
// PKG_ADD: __odbc_pkg_lock__(1);
// PKG_DEL: __odbc_pkg_lock__(0);
#ifdef DEFMETHOD_DLD
DEFMETHOD_DLD (__odbc_pkg_lock__, interp, args, , "internal function")
{
  octave_value retval;
  if (args.length () >= 1)
    {
      if (args(0).int_value () == 1)
        interp.mlock();
      else if (args(0).int_value () == 0 &&  interp.mislocked("__odbc_pkg_lock__"))
        interp.munlock("__odbc_pkg_lock__");
    }
  return retval;
}
#else
DEFUN_DLD(__odbc_pkg_lock__, args, ,  "internal function")
{
  octave_value retval;
  return retval;
}
#endif

// PKG_ADD: autoload ("__odbc_create__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_create__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_create__\n \
Private function\n \
@end deftypefn")
{
  if ( args.length() != 5 || !args (0).is_string () || !args (1).is_string () || !args (2).is_string () || !args(3).isnumeric() || !args(4).isnumeric())
    {
      print_usage ();
      return octave_value();
    }

  std::string db = args (0).string_value();
  std::string user = args (1).string_value();
  std::string pass = args (2).string_value();
  int flags = args (3).int_value();
  int timeout = args (4).int_value();

  init_types ();

  octave_odbc * retvalue = new octave_odbc ();

  if ( retvalue->create (db, user, pass, flags, timeout) == false )
    {
      error ("Error connecting: %s", retvalue->getMessage().c_str());
      delete retvalue;
      return octave_value ();
    }

  return octave_value (retvalue);
}

// PKG_ADD: autoload ("__odbc_close__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_close__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_close__\n \
Private function\n \
@end deftypefn")
{
  init_types ();

  if (args.length () != 1 || 
      args(0).type_id () != octave_odbc::static_type_id ())
    {
      print_usage ();
      return octave_value (false);  
    }

  octave_odbc * db = NULL;

  const octave_base_value& rep = args (0).get_rep ();

  db = &((octave_odbc &)rep);

  db->close();

  return octave_value (true);
}

// PKG_ADD: autoload ("__odbc_run__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_run__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_run__\n \
Private function\n \
@end deftypefn")
{
  init_types ();

  if (args.length () != 2 || 
      args(0).type_id () != octave_odbc::static_type_id () ||
      !args(1).is_string())
    {
      print_usage ();
      return octave_value (false);  
    }

  octave_odbc * db = NULL;

  const octave_base_value& rep = args (0).get_rep ();

  db = &((octave_odbc &)rep);
  std::string query = args (1).string_value ();

  octave_value v;
 
  if(db->run(query, v))
    {
      return octave_value (v);
    }
  else
    {
      error ("Could not run query: %s", db->getMessage().c_str());
      return octave_value();
    }
}

// PKG_ADD: autoload ("__odbc_rollback__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_rollback__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_run__\n \
Private function\n \
@end deftypefn")
{
  init_types ();

  if (args.length () != 1 || 
      args(0).type_id () != octave_odbc::static_type_id ())
    {
      print_usage ();
      return octave_value (false);  
    }

  octave_odbc * db = NULL;

  const octave_base_value& rep = args (0).get_rep ();

  db = &((octave_odbc &)rep);

  if(db->rollback())
    {
      return octave_value ();
    }
  else
    {
      error ("Could not run rollback: %s", db->getMessage().c_str());
      return octave_value();
    }
}

// PKG_ADD: autoload ("__odbc_commit__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_commit__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_commit__\n \
Private function\n \
@end deftypefn")
{
  init_types ();

  if (args.length () != 1 || 
      args(0).type_id () != octave_odbc::static_type_id ())
    {
      print_usage ();
      return octave_value (false);  
    }

  octave_odbc * db = NULL;

  const octave_base_value& rep = args (0).get_rep ();

  db = &((octave_odbc &)rep);

  if(db->commit())
    {
      return octave_value ();
    }
  else
    {
      error ("Could not run commit: %s", db->getMessage().c_str());
      return octave_value();
    }
}


// PKG_ADD: autoload ("__odbc_list__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_list__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_list__\n \
Private function\n \
@end deftypefn")
{
  Cell coldata[3];
  octave_idx_type row = 0;

  SQLRETURN rc;
  SQLHENV env;
  // Environment
  rc = SQLAllocHandle( SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);

  // ODBC: Version: Set
  rc = SQLSetEnvAttr( env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);

  SQLSMALLINT serverlen, desclen;
  SQLCHAR servername[1024];
  SQLCHAR description[1024];
  while((rc = SQLDataSources(env, SQL_FETCH_NEXT, servername, sizeof(servername), &serverlen, 
      description, sizeof(description), &desclen)) != SQL_NO_DATA)
    {
      if (rc == SQL_SUCCESS_WITH_INFO || rc == SQL_ERROR)
        {
          SQLCHAR       SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
          SQLINTEGER    NativeError;
          SQLSMALLINT   i, MsgLen;
          SQLRETURN     rc2;

          i = 1;
          while ((rc2 = SQLGetDiagRec(SQL_HANDLE_ENV, env, i, SqlState, &NativeError, Msg, sizeof(Msg), &MsgLen)) == SQL_SUCCESS || rc2 == SQL_SUCCESS_WITH_INFO)
            {
	      // TODO: do we want to show these messages ?
	      // printf("emsg: %lu %s '%s'\n", (unsigned long)NativeError, SqlState, (char*)Msg); 
	      i++;
	    }
        }

      if (rc == SQL_ERROR)
        break;
      else
        {
          if (coldata[0].numel() <= row)
            {
              coldata[0].resize(dim_vector(row+20, 1));
              coldata[1].resize(dim_vector(row+20, 1));
              coldata[2].resize(dim_vector(row+20, 1));
            }
          coldata[0](row) = octave_value((char*)servername);
          coldata[1](row) = octave_value("ODCB");
          coldata[2](row) = octave_value((char*)description);

          row ++;
        }
    }

  octave_map om;
  if (row > 0)
    {
      coldata[0].resize(dim_vector(row, 1));
      coldata[1].resize(dim_vector(row, 1));
      coldata[2].resize(dim_vector(row, 1));
    }

  om.assign("Name", octave_value(coldata[0]));
  om.assign("DriverType", octave_value(coldata[1]));
  om.assign("Vendor", octave_value(coldata[2]));

  SQLFreeHandle( SQL_HANDLE_ENV, env ); 

  return octave_value(om);
}

// PKG_ADD: autoload ("__odbc_find__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_find__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_find__\n \
Private function\n \
@end deftypefn")
{
  init_types ();

  if (args.length () < 1 || 
      args(0).type_id () != octave_odbc::static_type_id ())
    {
      print_usage ();
      return octave_value (false);  
    }

  std::string filter = "";
  if (args.length () > 1)
    {
      if (!args(1).is_string())
        {
          error ("Expected filtername as a string");
          return octave_value();
        }
      else
        {
          filter = args(1).string_value();
        }
    }

  octave_odbc * db = NULL;

  const octave_base_value& rep = args (0).get_rep ();

  db = &((octave_odbc &)rep);

  octave_value ret;

  db->find(filter, ret);

  return octave_value (ret);
  /*
  if(db->commit())
    {
      return octave_value ();
    }
  else
    {
      error ("Could not run commit: %s", db->getMessage().c_str());
      return octave_value();
    }
  */
}


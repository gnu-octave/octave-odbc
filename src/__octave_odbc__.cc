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
  bool create (const std::string &filename, const std::string &username, const std::string &password);
  void close (void);
  bool is_open() const;
  bool run (const std::string &query, octave_value &v);
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

  //odbc3 *db;

  SQLHENV env;
  SQLHDBC dbc;

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
  dbc = 0;
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
  os << "                  AutoCommit: 'on'"; newline(os);
  os << "                    ReadOnly: 'off'"; newline(os);
  os << "                LoginTimeout: 0"; newline(os);
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
	//else if (prop == "IsReadOnly")
	//  retval(0) = octave_value(mode == "readonly");
	//else if (prop == "AutoCommit")
	 // retval(0) = autocommit;
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
          error ("octave_odbc invalid index");
/*
          octave_value prop = (idx.front ()) (0);
	  if (!prop.is_string() || prop.string_value() != "AutoCommit")
	    {
              error ("octave_odbc Unknown property");
	    }
	  else if(!rhs.is_string() || (rhs.string_value() != "on" && rhs.string_value() != "off"))
	  {
              error ("Expected AUtoCommit as 'on' or 'off'");

	  }
	  else
	  {
	    std::string  newautocommit = rhs.string_value();

	    if (newautocommit != autocommit)
	    {
              if (newautocommit == "off")
	      {
		if(begin())
	          autocommit = newautocommit;
	      }
              if (newautocommit == "on")
	      {
                // TODO: do we commit or rollback if go from on to off with stuff there ?
		if (have_pending_commits())
		  error ("Pending commits need to be commited or rolledback before changing commit state");
                else
		{
		  rollback(); // should be nothing to reject really, but need to get out of transaction state
	          autocommit = newautocommit;
		}
	      }
            }
            OV_COUNT++;
            retval = octave_value (this);
	  }
*/
        }
      else
        {
          error ("octave_odbc invalid index");
        }
    }
  return retval;
}

bool
octave_odbc::create (const std::string &dbname, const std::string &username, const std::string &password)
{
  SQLRETURN rc;


  // Environment
  rc = SQLAllocHandle( SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);

  // ODBC: Version: Set
  rc = SQLSetEnvAttr( env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);

  // DBC: Allocate
       rc = SQLAllocHandle( SQL_HANDLE_DBC, env, &dbc);

  //rc =     SQLSetConnectAttr(hdbc, SQL_LOGIN_TIMEOUT, (SQLPOINTER)5, 0);

  // are we a db dsn name, or a connection dtring ?
  // TODO: need parse out some options here ?and set them or sqlconnect will handle ?
  // pullout timeout at least so we know it? or query it and set after connected ????????
  // UID ? for username

  // connection string
  if (dbname.find('=') != std::string::npos)
  {
	  SQLCHAR outname[1024];
	  SQLSMALLINT outlen;

    rc = SQLDriverConnect( dbc, NULL, (SQLCHAR*) dbname.c_str(), dbname.length(), outname, sizeof(outname), &outlen, SQL_DRIVER_NOPROMPT);
printf("out: %s\n", (char*)outname);
  }
  else
    // DBC: Connect
    rc = SQLConnect( dbc, (SQLCHAR*) dbname.c_str(), SQL_NTS,
      (SQLCHAR*) username.c_str(), SQL_NTS,
      (SQLCHAR*) password.c_str(), SQL_NTS);

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

  rc = SQLGetInfo(dbc, SQL_DATA_SOURCE_NAME, szName, sizeof(szName), &cbName);
  printf("DS %s\n", (char*)szName);

  rc = SQLGetInfo(dbc, SQL_DRIVER_NAME, szName, sizeof(szName), &cbName);
  printf("DN %s\n", (char*)szName);
  db_driver_name = (char*)szName;

  //rc = SQLGetInfo(dbc, SQL_DRIVER_ODBC_VER, szName, sizeof(szName), &cbName);

  rc = SQLGetInfo(dbc, SQL_DRIVER_VER, szName, sizeof(szName), &cbName);
  db_driver_ver = (char*)szName;

  rc = SQLGetInfo(dbc, SQL_DATABASE_NAME, szName, sizeof(szName), &cbName);
  printf("DBN %s\n", (char*)szName);

  rc = SQLGetInfo(dbc, SQL_DBMS_VER, szName, sizeof(szName), &cbName);
  db_ver = (char*)szName;

  rc = SQLGetInfo(dbc, SQL_DBMS_NAME, szName, sizeof(szName), &cbName);
  printf("DB %s\n", (char*)szName);
  db_name = (char *)szName;

  return true;
}

void
octave_odbc::close (void)
{
  if (dbc)
    {
      SQLDisconnect( dbc );
      SQLFreeHandle( SQL_HANDLE_DBC, dbc );
      SQLFreeHandle( SQL_HANDLE_ENV, env ); 
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
octave_odbc::run (const std::string &query, octave_value &v)
{
  v = Cell();

  SQLRETURN rc;
  SQLHSTMT hstmt;  

  rc = SQLAllocHandle(SQL_HANDLE_STMT, dbc, &hstmt);  

  SQLCHAR SQLStatement[1024];
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
      SQLFreeHandle( SQL_HANDLE_DBC, hstmt);
      return false;
    }

  SQLSMALLINT cols = 0;
  rc = SQLNumResultCols(hstmt, &cols);

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
                  SQLCHAR      szName[256];
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

// PKG_ADD: autoload ("__odbc_create__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_create__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_create__\n \
Private function\n \
@end deftypefn")
{
  if ( args.length() != 3 || !args (0).is_string () || !args (1).is_string () || !args (2).is_string ())
    {
      print_usage ();
      return octave_value();
    }

  std::string db = args (0).string_value();
  std::string user = args (1).string_value();
  std::string pass = args (2).string_value();

  init_types ();
  printf("odbc: %s %s\n", db.c_str(), user.c_str());

  octave_odbc * retvalue = new octave_odbc ();

  if ( retvalue->create (db, user, pass) == false )
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

// PKG_ADD: autoload ("__odbc_list__", "__octave_odbc__.oct");
DEFUN_DLD(__odbc_list__, args, nargout,
"-*- texinfo -*-\n \
@deftypefn {Function File} {} __odbc_run__\n \
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


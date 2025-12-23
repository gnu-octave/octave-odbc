## Copyright (C) 2024 John Donoghue <john.donoghue@ieee.org>
##
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

classdef connection < handle
  ## -*- texinfo -*-
  ## @deftp {Class} connection
  ## Connection class for a ODBC database connection
  ## @subsubheading Object Properties
  ## @table @asis
  ## @item DataSource
  ## Datasource value as passed during creation
  ## @item UserName
  ## Username value as passed during creation
  ## @item Password
  ## Password value as passed during creation
  ## @item Message
  ## Readonly last error message
  ## @item Type
  ## 'ODBC Connection Object'
  ## @item ReadOnly
  ## Boolean for readonly access passed during creation
  ## @item AutoCommit
  ## Boolean for control of commit to database
  ## @item LoginTimeout
  ## Number of seconds for a login timeout
  ## @end table
  ##
  ## Class is created using the odbc or database function.
  ## @seealso{odbc, database}
  ## @end deftp
 
  properties (SetAccess=protected, GetAccess=public)
    # read only properties

    DataSource = ''; # DataSource value
    UserName = '';   # Username
    Message = '';    # Last message from database access
    Type = 'ODBC Connection Object'; # connection type

    ReadOnly = 'off';
    LoginTimeout = 0;
  endproperties

  properties (SetAccess=public, GetAccess=public)
    AutoCommit = 'on';
    # more stuff .....
  endproperties

  properties (Access = private)
    dbhandle = [];
  endproperties

  methods
    function this = connection (databasename, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{conn} =} connection (@var{conn}, @var{varargs})
      ## ODCB connection constructor
      ## @end deftypefn

      if nargin < 1 || !ischar(databasename)
        error ("Expected database name as a string");
      endif
      
      username = "";
      password = "";
      readonly = 0;
      autocommit = 1;
      timeout = 0;

      prop_idx = 1;
      if nargin > 1
        if ! this.isinputprop(varargin{1})
          username = varargin{1};
          password = varargin{2};
          prop_idx = 3;
        endif
      endif
      if prop_idx < nargin
        if mod (nargin-prop_idx, 2) != 0
          error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (prop_idx:2:nargin-1))
          error ("expected property names to be strings");
        endif

        for idx=prop_idx:2:nargin-1

          n = lower(varargin{idx});
          v = varargin{idx+1};

          if strcmp(n, "username")
            username = v;
          elseif strcmp(n, "password")
            password = v;
          elseif strcmp(n, "autocommit")
            if !ischar(v) 
             error ("expected autocommit value to be a string");
            elseif strcmpi(v, "on")
              autocommit = 1;
            elseif strcmpi(v, "off")
              autocommit = 0;
            else
              error ("expected autocommit value to be on or off");
            endif
          elseif strcmp(n, "logintimeout")
            if !isnumeric(v) || v <= 0
             error ("expected login timeout value to be positive numeric");
            endif
            timeout = int32(v);
          elseif strcmp(n, "readonly")
            if !ischar(v) 
             error ("expected readonly value to be a string");
            elseif strcmpi(v, "on")
              readonly = 1;
            elseif strcmpi(v, "off")
              readonly = 0;
            else
              error ("expected readonly value to be on or off");
            endif
          else
            error ("Unknown property '%s'", n);
          endif
        endfor
      endif

      if !ischar(username)
        error ("Username should be a string");
      endif
      if !ischar(password)
        error ("Password should be a string");
      endif

      this.DataSource = databasename;
      this.UserName = username;

      flags = 0;

      this.ReadOnly = "off";
      if readonly
        this.ReadOnly = "on";
        flags = flags + 1;
      endif

      this.AutoCommit = "off";
      if autocommit
        this.AutoCommit = "on";
        flags = flags + 2;
      endif

      this.dbhandle = __odbc_create__(databasename, username, password, flags, timeout);
    endfunction

    function delete (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {} delete (@var{conn})
      ## ODCB connection deconstructor
      ## @end deftypefn

      try
        this.dbhandle = [];
      catch
        # do nothing
      end_try_catch
    endfunction

    function Y = isopen (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{T} =} isopen (@var{conn})
      ## Return true if ODCB connection is open
      ## @end deftypefn

      Y = ! isempty(this.dbhandle);
    endfunction

    function close (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {} close (@var{conn})
      ## close ODCB connection
      ## @end deftypefn

      if !isempty(this.dbhandle)
        __odbc_close__(this.dbhandle);
        this.dbhandle = [];
      endif
      this.Message = "Closed";
    endfunction

    # runstoredprocedure
    
    function data = sqlouterjoin (this, lefttable, righttable, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} sqlouterjoin (@var{db}, @var{lefttablename}, @var{righttablename})
      ## @deftypefnx {} {@var{data} =} sqlouterjoin (@var{db}, @var{lefttablename}, @var{righttablename}, "Keys", @var{keys}, @dots{})
      ## @deftypefnx {} {@var{data} =} sqlouterjoin (@var{db}, @var{lefttablename}, @var{righttablename}, "LeftKeys", @var{keys}, "RightKeys", @var{keys}, @dots{})
      ## Perform an outerjoin on two tables.
      ## 
      ## Performs an outerjoin equivalent to 'SELECT * from lefttable OUTER JOIN righttable ON lefttable.key = rightable.key'.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created connection object
      ## @item @var{lefttablename}
      ## Name of lefthand table
      ## @item @var{righttablename}
      ## Name of righthand table
      ## @item @var{keys}
      ## A string or cellstring of column names to join against.
      ## If specified as Keys, the names will be used on lefthand and rightside of the join.
      ## If specified as LeftKeys and RightKeys, keys will be used separately for each side of the table.
      ## If no keys are provided, common named columns will be matched between the tables.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item MaxRows
      ##  Max number of rows to return.
      ##  @item DataReturnFormat
      ##  Format to return data in ('table', 'structure', 'cellarray')
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @seealso{database, odbc, fetch, sqlinnerjoin}
      ## @end deftypefn

      if !ischar(lefttable) || !ischar(righttable)
        error ("Expected left and right table as a string");
      endif

      if numel(varargin) > 0
        if mod (numel(varargin), 2) != 0
          error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (1:2:numel(varargin)))
          error ("expected property names to be strings");
        endif
      endif

      passon_args = {};
      keys = {};
      leftkeys = {};
      rightkeys = {};
      for idx=1:2:numel(varargin)
        n = varargin{idx};
        v = varargin{idx+1};
        if strcmp(n, "Keys")
          keys = v;
        elseif strcmp(n, "LeftKeys")
          leftkeys = v;
        elseif strcmp(n, "RightKeys")
          rightkeys = v;
        else
          passon_args{end+1} = n;
          passon_args{end+1} = v;
        endif
      endfor
 
      where_cnt = 0;
      sqlquery = sprintf("SELECT * FROM %s FULL OUTER JOIN %s ON ", lefttable, righttable);

      if isempty(keys) && isempty(leftkeys) && isempty(rightkeys)
        ldata = _run(this, sprintf("SELECT * FROM '%s' LIMIT 1",  lefttable), "structure");
        rdata = _run(this, sprintf("SELECT * FROM '%s' LIMIT 1",  righttable), "structure");

        lcols = fieldnames(ldata);
        rcols = fieldnames(rdata);

        for idx=1:length(lcols)
          z = ismember(lcols{idx}, rcols);
          if sum(z) > 0
            if where_cnt > 0
              sqlquery = [sqlquery " AND "];
            endif
            sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, lcols{idx}, righttable, lcols{idx})];
            where_cnt = where_cnt + 1;
          endif
        endfor

        if where_cnt == 0
          error ("no common columns found in tables");
        endif
      elseif !isempty(keys) && isempty(leftkeys) && isempty(rightkeys)
        if ischar(keys)
          keys = {keys};
        endif
        if !iscellstr(keys)
          error ("Expected Keys as string or cellstring");
        endif
        for idx=1:length(keys)
          if where_cnt > 0
            sqlquery = [sqlquery " AND "];
          endif
          sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, keys{idx}, righttable, keys{idx})];
          where_cnt = where_cnt + 1;
        endfor
      elseif isempty(keys) && !isempty(leftkeys) && !isempty(rightkeys)
        if ischar(leftkeys)
          leftkeys = {leftkeys};
        endif
        if ischar(rightkeys)
          rightkeys = {rightkeys};
        endif

        if !iscellstr(leftkeys) || !iscellstr(rightkeys)
          error ("Expected LeftKeys and RightKeys as string or cellstring");
        endif
        if size(leftkeys) != size(rightkeys)
          error ("Expected LeftKeys and RightKeys to be same size");
        endif

        for idx=1:length(leftkeys)
          if where_cnt > 0
            sqlquery = [sqlquery " AND "];
          endif
          sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, leftkeys{idx}, righttable, rightkeys{idx})];
          where_cnt = where_cnt + 1;
        endfor
      else
        error ("Expected Keys or LeftKeys and RightKeys");
      endif

      if where_cnt == 0
        error ("no constraint columns specified in keys");
      endif

      data = fetch(this, sqlquery, passon_args{:});
    endfunction
    
    function data = sqlinnerjoin (this, lefttable, righttable, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} sqlinnerjoin (@var{db}, @var{lefttablename}, @var{righttablename})
      ## @deftypefnx {} {@var{data} =} sqlinnerjoin (@var{db}, @var{lefttablename}, @var{righttablename}, "Keys", @var{keys}, @dots{})
      ## @deftypefnx {} {@var{data} =} sqlinnerjoin (@var{db}, @var{lefttablename}, @var{righttablename}, "LeftKeys", @var{keys}, "RightKeys", @var{keys}, @dots{})
      ## Perform an innerjoin on two tables.
      ## 
      ## Performs an innerjoin equivalent to 'SELECT * from lefttable INNER JOIN righttable ON lefttable.key = rightable.key'.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created connection object
      ## @item @var{lefttablename}
      ## Name of lefthand table
      ## @item @var{righttablename}
      ## Name of righthand table
      ## @item @var{keys}
      ## A string or cellstring of column names to join against.
      ## If specified as Keys, the names will be used on lefthand and rightside of the join.
      ## If specified as LeftKeys and RightKeys, keys will be used separately for each side of the table.
      ## If no keys are provided, common named columns will be matched between the tables.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  Property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item MaxRows
      ##  Max number of rows to return.
      ##  @item DataReturnFormat
      ##  Format to return data in ('table', 'structure', 'cellarray')
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @seealso{database, odbc, fetch, sqlouterjoin}
      ## @end deftypefn

      if !ischar(lefttable) || !ischar(righttable)
        error ("Expected left and right table as a string");
      endif

      if numel(varargin) > 0
        if mod (numel(varargin), 2) != 0
          error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (1:2:numel(varargin)))
          error ("expected property names to be strings");
        endif
      endif

      passon_args = {};
      keys = {};
      leftkeys = {};
      rightkeys = {};
      for idx=1:2:numel(varargin)
        n = varargin{idx};
        v = varargin{idx+1};
        if strcmp(n, "Keys")
          keys = v;
        elseif strcmp(n, "LeftKeys")
          leftkeys = v;
        elseif strcmp(n, "RightKeys")
          rightkeys = v;
        else
          passon_args{end+1} = n;
          passon_args{end+1} = v;
        endif
      endfor
 
      where_cnt = 0;
      #sqlquery = sprintf("SELECT * FROM %s,%s WHERE ", lefttable, righttable);
      sqlquery = sprintf("SELECT * FROM %s INNER JOIN %s ON ", lefttable, righttable);

      if isempty(keys) && isempty(leftkeys) && isempty(rightkeys)
        ldata = _run(this, sprintf("SELECT * FROM '%s' LIMIT 1",  lefttable), "structure");
        rdata = _run(this, sprintf("SELECT * FROM '%s' LIMIT 1",  righttable), "structure");

        lcols = fieldnames(ldata);
        rcols = fieldnames(rdata);

        for idx=1:length(lcols)
          z = ismember(lcols{idx}, rcols);
          if sum(z) > 0
            if where_cnt > 0
              sqlquery = [sqlquery " AND "];
            endif
            sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, lcols{idx}, righttable, lcols{idx})];
            where_cnt = where_cnt + 1;
          endif
        endfor

        if where_cnt == 0
          error ("no common columns found in tables");
        endif
      elseif !isempty(keys) && isempty(leftkeys) && isempty(rightkeys)
        if ischar(keys)
          keys = {keys};
        endif
        if !iscellstr(keys)
          error ("Expected Keys as string or cellstring");
        endif
        for idx=1:length(keys)
          if where_cnt > 0
            sqlquery = [sqlquery " AND "];
          endif
          sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, keys{idx}, righttable, keys{idx})];
          where_cnt = where_cnt + 1;
        endfor
      elseif isempty(keys) && !isempty(leftkeys) && !isempty(rightkeys)
        if ischar(leftkeys)
          leftkeys = {leftkeys};
        endif
        if ischar(rightkeys)
          rightkeys = {rightkeys};
        endif

        if !iscellstr(leftkeys) || !iscellstr(rightkeys)
          error ("Expected LeftKeys and RightKeys as string or cellstring");
        endif
        if size(leftkeys) != size(rightkeys)
          error ("Expected LeftKeys and RightKeys to be same size");
        endif

        for idx=1:length(leftkeys)
          if where_cnt > 0
            sqlquery = [sqlquery " AND "];
          endif
          sqlquery = [sqlquery sprintf("%s.%s = %s.%s", lefttable, leftkeys{idx}, righttable, rightkeys{idx})];
          where_cnt = where_cnt + 1;
        endfor
      else
        error ("Expected Keys or LeftKeys and RightKeys");
      endif

      if where_cnt == 0
        error ("no constraint columns specified in keys");
      endif

      data = fetch(this, sqlquery, passon_args{:});
    endfunction
   
    function sqlwrite (this, tablename, data, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {} sqlwrite (@var{db}, @var{tablename}, @var{data})
      ## @deftypefnx {} {} sqlwrite (@var{db}, @var{tablename}, @var{data}, @var{columntypes})
      ## @deftypefnx {} {} sqlwrite (@var{db}, @var{tablename}, @var{data}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Insert rows of data into a table.
      ##
      ## Insert rows of data into a database table.
      ## If the table does not exist it will be created, using the ColumnType property if available
      ## otherwise, the type of input data will be used to determine field types.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created database connection object
      ## @item @var{tablename}
      ## Name of table to write data to
      ## @item @var{data}
      ## Table containing data to write to the database. Variables names are expected to match the database.
      ## @item @var{columntypes}
      ## Optional cell array of same size as data used if table must be created. The column types may also
      ## be passed in using the @var{propertyname}, @var{propertyvalue} syntax.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item ColumnType
      ##  Optional cell array of same size as the data that may be used
      ##  if the table is created as part of the write operation.
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @seealso{database, odbc, sqlread}
      ## @end deftypefn

      if nargin < 3 || nargin > 5
        print_usage();
      endif

      if !ischar(tablename)
        error ("Expected tablename as a string");
      endif

      coltypes = {};
      if nargin == 5
        # "ColumnType", value
        if !ischar(varargin{1}) || !strcmp(varargin{1}, "ColumnType")
          error ("Expected optional property as 'ColumnType'");
        endif
        coltypes = varargin{2};  
      elseif nargin == 4
        coltypes = varargin{1};  
      endif

      if isa(data, "dbtable")
        data = table2struct(data);
      elseif isa(data, "table")
        data = table2struct(data, 'ToScalar', true);
      elseif iscell(data)
        data = cell2struct(data);
      elseif !isstruct(data)
        error ("Expected input data as a table or struct");
      endif

      cols = fieldnames(data);

      if !isempty(coltypes)
        if !iscellstr(coltypes)
          error ("Expected ColumnType to be a cell string");
        endif

        if size(coltypes, 2) != size(cols)
          error ("Expected ColumnType to match data column count size");
        endif
      endif

      sql = sprintf ('INSERT INTO %s (', tablename);
      for col=1:numel(cols)
        if col > 1
          sql = [sql "," ];
        endif
        sql = [sql cols{col}];
      endfor
      sql = [sql ") VALUES \n"];
      for idx = 1:length(data.(cols{1}))
        values = "";
        for col=1:numel(cols)
          if col > 1
            values = [values ","];
          endif
          v = data.(cols{col});
          if ismatrix(v)
            v = v(idx,:);
          else
            v = v{idx};
          endif
          if iscell(v)
            v = v{1};
          endif
          if islogical(v)
            if v
              v = 1;
            else
              v = 0;
            endif
          endif

          if isnumeric(v)
             v = num2str(v);
          else
             v = ["'" v "'"];
          endif
          values = [values v];

        endfor

        if idx > 1
          sql = [sql ",\n"];
        endif
        sql = [sql "(" values ");"];

      endfor

      # create table if we need to ?
      if isempty(coltypes)
        coltypes = {};
        # currently assign all columns to numeric if not specified as it will
        # handle all types of data
        for col=1:numel(cols)
          coltypes{end+1} = this.calc_type(data.(cols{col}));
        endfor
      endif
      tsql = sprintf("CREATE TABLE IF NOT EXISTS %s (", tablename);
      for idx=1:numel(coltypes)
        if idx > 1
          tsql = [tsql ", "];
        endif
        tsql = [tsql sprintf("%s %s", cols{idx}, coltypes{idx})];
      endfor 
      tsql = [tsql ");"];

      if !isempty(coltypes)
        execute(this, tsql);
      endif
      if length(data.(cols{1}))
        execute(this, sql);
      endif

    endfunction
   
    function results = executeSQLScript (this, filename, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{results} =} executeSQLScript (@var{conn}, @var{scriptname})
      ## Run statements from a script file
      ## 
      ## @subsubheading Inputs
      ## @table @code
      ## @item @var{conn}
      ## ODBC connection object
      ## @item @var{scriptname}
      ## Filename to read statements from. NOTE: currently the file is expected to contain one statement per line.
      ## @end table
      ##
      ## @subsubheading Outputs
      ## @table @code
      ## @item @var{results}
      ## A struct with fields SQLQuery, Data and Message for each SQL statement in the file.
      ## @end table
      ##
      ## @end deftypefn

      if nargin < 2 || !ischar(filename)
        error ("Expected filename as string.");
      endif

      # TODO: process input properties
      # TODO: process statements which could be multiline, contain comments etc

      results = {};

      query = {};
      data = {};
      mess = {};

      fid = fopen(filename, "rt");
      if fid < 0
        error ("Could not open file '%s'", filename);
      endif 

      unwind_protect
        while !feof(fid)
          l = fgetl(fid);
          l = strtrim(l);
          if !isempty(l)
            t = fetch(this, l, varargin{:});
            query{end+1} = l;
            data{end+1} = t;
            mess{end+1} = this.Message;
          endif
        endwhile
      unwind_protect_cleanup
        fclose(fid);
      end_unwind_protect

      results = struct("SQLQuery", query, "Data", data, "Message", mess);
    endfunction

    function data = fetch (this, query, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} fetch (@var{conn}, @var{query})
      ## @deftypefnx {} {@var{data} =} fetch (@var{conn}, @var{query}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Perform SQL query @var{query}, and return result
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ##  currently open database connection.
      ## @item @var{sqlquery}
      ##  String containing a valid select SQL query.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item MaxRows
      ##   Integer value of max number of rows in the query
      ##  @item VariableNamingRule
      ##   String value 'preserve' (default) or 'modify' to flag renaming of variable names (currently ignored)
      ##  @item RowFilter
      ##   rowfilter object to filter results
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## @table @asis
      ## @item @var{data}
      ##  a table containing the query result.
      ## @end table
      ##
      ## @subsubheading Examples
      ## Select all rows of data from a database tables
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## data = fetch(db, 'SELECT * FROM TestTable');
      ## }
      ## @end example
      ##
      ## Select 5 rows of data from a database tables
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## data = fetch(db, 'SELECT * FROM TestTable', "MaxRows", 5);
      ## }
      ## @end example
      ##
      ## @seealso{database, connection}
      ## @end deftypefn

      if !ischar(query)
        error ("Expected sqlquery as a string");
      endif

      if numel(varargin) >0
        if mod (numel(varargin), 2) != 0
          error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (1:2:numel(varargin)))
          error ("expected property names to be strings");
        endif
      endif

      maxrows = [];
      rowfilter = [];
      debug = 0;
      format = "table";
 
      for idx=1:2:numel(varargin)
        n = varargin{idx};
        v = varargin{idx+1};
        if strcmp(n, "MaxRows")
          maxrows = num2str(v);
        elseif strcmp(n, "Debug")
          debug = v;
        elseif strcmp(n, "DataReturnFormat")
          format = v;
        elseif strcmp(n, "VariableNamingRule")
          if !ischar(v) || sum(strcmp(v, {'preserve', 'modify'})) != 1
            error ("Expected VariableNamingRule property value to be 'preserve' or 'modify'");
          endif
          # TODO
          #
        elseif strcmp(n, "RowFilter")
          if !isa(v, "rowfilter")
            error ("Expected RowFilter to be a rowfilter class");
          endif
          rowfilter = v;
        else
          error ("Unknown property name '%s'", n);
        endif
      endfor
  
      if !isempty(rowfilter)
        query = [query " WHERE " char(rowfilter)];
      endif

      if !isempty(maxrows)
        query = [query " LIMIT " maxrows];
      endif

      if debug
        printf("Query: '%s'\n", query);
      endif

      data = _run(this, query, format);
    endfunction

    function data = select (this, sqlquery, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} select (@var{conn}, @var{query})
      ## @deftypefnx {} {@var{data} =} select (@var{conn}, @var{query}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Perform SQL query @var{query}, and return result
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ##  currently open database connection.
      ## @item @var{query}
      ##  String containing a valid select SQL query.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item MaxRows
      ##   Integer value of max number of rows in the query
      ##  @item VariableNamingRule
      ##   String value 'preserve' (default) or 'modify' to flag renaming of variable names (currently ignored)
      ##  @item RowFilter
      ##   rowfilter object to filter results
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## @table @asis
      ## @item @var{data}
      ##  a table containing the query result.
      ## @end table
      ##
      ## @subsubheading Examples
      ## Select all rows of data from a database tables
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## data = fetch(db, 'SELECT * FROM TestTable');
      ## }
      ## @end example
      ##
      ## Select 5 rows of data from a database tables
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## data = fetch(db, 'SELECT * FROM TestTable', "MaxRows", 5);
      ## }
      ## @end example
      ##
      ## @seealso{database, connection}
      ## @end deftypefn

      # TODO: verify statement is SELECT ... ?
      data = fetch(this, sqlquery, varargin{:});
    endfunction

    function execute (this, sqlquery)
      ## -*- texinfo -*-
      ## @deftypefn {} {} execute (@var{conn}, @var{query})
      ## Perform SQL query @var{query}, that does not return result
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created database connection object
      ## @item @var{sqlquery}
      ## A valid non selecting SQL query string
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @subsubheading Examples
      ## Create a database table and insert a row
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## # create table and then insert a row
      ## execute(db, 'CREATE TABLE Test (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT)');
      ## execute(db, 'INSERT INTO Test (Name) VALUES ("Line1")');
      ## }
      ## @end example
      ##
      ## @seealso{database, fetch}
      ## @end deftypefn
      _run(this, sqlquery);
    endfunction

    function data = sqlread (this, tablename, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} sqlread (@var{conn}, @var{tablename})
      ## @deftypefnx {} {@var{data} =} sqlread (@var{conn}, @var{tablename}, @var{propertryname}, @var{propertyvalue})
      ## Read data from table @var{tablename}
      ##
      ## Return rows of data from table @var{tablename} in a database.
      ## This function is the equivalent of running SELECT * FROM @var{table}.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ##  currently open database.
      ## @item @var{tablename}
      ##  Name of a table with the database.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item MaxRows
      ##   Integer value of max number of rows in the query
      ##  @item VariableNamingRule
      ##   String value 'preserve' (default) or 'modify' to flag renaming of variable names (currently ignored)
      ##  @item RowFilter
      ##   rowfilter object to filter results
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## @table @asis
      ## @item @var{data}
      ##  a table containing the query result.
      ## @end table
      ##
      ## @subsubheading Examples
      ## Select all rows of data from a database table
      ## @example
      ## @code {
      ## # create sql connection to an existing database
      ## db = database("default", "", "");
      ## data = sqlread(db, 'TestTable');
      ## }
      ## @end example
      ##
      ## Select 5 rows of data from a database table
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## data = sqlread(db, 'TestTable', "MaxRows", 5);
      ## }
      ## @end example
      ##
      ## @seealso{database, fetch}
      ## @end deftypefn

      if nargin < 2 || !ischar(tablename)
        error ("Expected tablename as a string");
      endif

      if numel(varargin) > 0
        if mod (numel(varargin), 2) != 0
           error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (1:2:numel(varargin)))
          error ("expected property names to be strings");
        endif
      endif
 
      ## select data from database
      sqlquery = ["SELECT * FROM " tablename];
      data = fetch(this, sqlquery, varargin{:});
    endfunction

    function commit (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {} commit (@var{conn})
      ## Make permanent changes to the database.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ##  currently open database.
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ## @end deftypefn
      __odbc_commit__(this.dbhandle);
    endfunction

    function rollback (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {} rollback (@var{conn})
      ## Rollback changes to the database.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ##  currently open database.
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ## @end deftypefn
      __odbc_rollback__(this.dbhandle);
    endfunction

    function update(conn,tablename,colnames,data,whereclause)
      ## -*- texinfo -*-
      ## @deftypefn {} {} update (@var{conn}, @var{tablename}, @var{colnames}, @var{data}, @var{whereclause})
      ## Update columns in database.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{conn}
      ## Previously created database connection object
      ## @item @var{tablename}
      ## Name of table to write data to
      ## @item @var{colnames}
      ## cellstr of column names update. Variables names are expected to match the database.
      ## @item @var{data}
      ## Table or struct containing data to write to the database. Column names are expected to be present in the data..
      ## @item @var{whereclause}
      ## String WHERE condition to meet for updates.
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @subsubheading Examples
      ## Update a row in the database
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## # update name where Id > 1
      ## t = table(['Name3'], 'VariableNames', @{'Name'@});
      ## update(db, "Test", t, "WHERE Id > 1");
      ## }
      ## @end example
      ##
      ## @seealso{sqlupdate}
      ## @end deftypefn
 
      sqlquery = "";

      if nargin != 5
        error ("update: expected tablename, colnames, data and whereclause");
      endif

      if !ischar(tablename)
        error ("Expected tablename as a string");
      endif

      if !ischar(whereclause)
        error ("Expected whereclause as a string");
      endif

      if isa(data, "dbtable")
        data = table2struct(data);
      elseif isa(data, "table")
        data = table2struct(data, 'ToScalar', true);
      elseif !isstruct(data)
        error ("Expected table or struct data");
      endif

      if !iscellstr(colnames)
        error ("Expected colnames as cellstr");
      endif

      sql = sprintf("UPDATE %s SET ", tablename);

      for col=1:numel(colnames)
        if col > 1
          sql = [sql "," ];
        endif
        v = data.(colnames{col});

        if islogical(v)
          if v
            v = 1;
          else
            v = 0;
          endif
        endif

        if isnumeric(v)
           v = num2str(v);
        else
           v = ["'" v "'"];
        endif
 
        sql = [sql colnames{col} " = " v];
      endfor

      sql = [sql " " whereclause ";"];
 
      execute(conn, sql);
 
    endfunction

    function sqlupdate(conn, tablename, data, filter, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {} sqlupdate (@var{db}, @var{tablename}, @var{data}, @var{filter})
      ## @deftypefnx {} {} sqlupdate (@var{db}, @var{tablename}, @var{data}, @var{filter}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Update rows of data in database.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created database connection object
      ## @item @var{tablename}
      ## Name of table to write data to
      ## @item @var{data}
      ## Table containing or struct data to write to the database. Variables names are expected to match the database.
      ## @item @var{filter}
      ## A Filter object  or cell array of filter objects used to determine which rows of the table to update.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item Catalog
      ##  An optional database catalog name.
      ##  @item Schema
      ##  An optional database schema name.
      ##  @end table
      ## @end table
      ##
      ## @subsubheading Outputs
      ## None
      ##
      ## @subsubheading Examples
      ## Update db where id > 1
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## # make a filter to select what to update
      ## rf = rowfilter(@{'Id'@});
      ## rf = rf.Id > 1;
      ## # update name where Id > 1
      ## t = table(['Name3'], 'VariableNames', @{'Name'@});
      ## sqlupdate(db, "Test", t, rf);
      ## }
      ## @end example
      ##
      ## @seealso{update}
      ## @end deftypefn
 
      sqlquery = "";

      if mod (nargin, 2) != 0
        error ("sqlupdate: expected property name, value pairs");
      endif
      if !iscellstr (varargin (1:2:nargin-4))
        error ("sqlupdate: expected property names to be strings");
      endif
 
      if !ischar(tablename)
        error ("Expected tablename as a string");
      endif

      if isa(data, "dbtable")
        #data = table2struct(data);
        cols = subsref (data, substruct(".", "Properties")).VariableNames;
      elseif isa(data, "table")
        #data = table2struct(data, 'ToScalar', true);
        cols = subsref (data, substruct(".", "Properties")).VariableNames;
      elseif isstruct(data)
        cols = fieldnames(data);
      else
        error ("Expected table or struct data");
      endif

      for i = 1:2:nargin-4
        propname = tolower (varargin{i});
        propvalue = varargin{i+1};

        # currently not using the properties, but verify name at least
        if strcmp(propname, "schema") == false &&  strcmp(propname, "catalog") == false
          error ("sqlupdate: Unknown property name '%s'", propname);
        endif
      endfor

      update(conn, tablename, cols, data, ["WHERE " char(filter)]);
    endfunction

    function data = sqlfind (this, pattern, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} sqlfind (@var{db}, @var{pattern})
      ## @deftypefnx {} {@var{data} =} sqlfind (@var{db}, @var{pattern}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Find information about table types in a database.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ##  currently open database.
      ## @item @var{pattern}
      ##  Name or pattern to match table in database. Use '' to match match all tables.
      ## @item @var{propertyname}, @var{propertyvalue}
      ##  property name/value pairs where known properties are:
      ##  @table @asis
      ##  @item Catalog
      ##   catalog value to match
      ##  @item Schema
      ##   schema value to match
      ##  @end table
      ## @end table
      ##
      ## Note: currently the property values are not used in the filter process.
      ##
      ## @subsubheading Outputs
      ## @table @asis
      ## @item @var{data}
      ##  a table containing the query result. Table columns are
      ## 'Catalog', 'Schema', 'Table', 'Columns', 'Type'.
      ## @end table
      ##
      ## @subsubheading Examples
      ## Show all tables in the database.
      ## @example
      ## @code {
      ## # create sql connection to an existing database
      ## db = database("default", "", "");
      ## # list all tables
      ## data = sqlfind(db, '');
      ## }
      ## @end example
      ##
      ## Show information about TestTable
      ## @example
      ## @code {
      ## # create sql connection
      ## db = database("default", "", "");
      ## # list matching tables
      ## data = sqlfind(db, 'TestTable');
      ## }
      ## @end example
      ##
      ## @seealso{database, sqlread}
      ## @end deftypefn

      if numel(varargin) > 0
        if mod (numel(varargin), 2) != 0
          error ("expected property name, value pairs");
        endif
        if !iscellstr (varargin (1:2:numel(varargin)))
          error ("expected property names to be strings");
        endif
      endif

      catalog = "%";
      schema = "%"
      if isempty(pattern)
        pattern = "%";
      endif

      for idx=1:2:numel(varargin)
        n = varargin{idx};
        v = varargin{idx+1};
        if strcmp(n, "Catalog")
          if !ischar(v)
            error ("Expected Catalog property value to be a string");
          endif
          catalog = v;
        elseif strcmp(n, "Schema")
          if !ischar(v)
            error ("Expected Schema property value to be a string");
          endif
          schema = v;
        else
          error ("Unknown property name '%s'", n);
        endif
      endfor
 
      xdata = __odbc_find__(this.dbhandle, pattern, catalog, schema);
      data = format_data(this, xdata);
    endfunction
 
    function disp(this)
      ## Display information about the database
      
      printf ("  connection with properties:\n");
      printf ("                  DataSource: '%s'\n", this.DataSource);
      printf ("                    UserName: '%s'\n", this.UserName);
      printf ("                     Message: '%s'\n", this.Message);
      printf ("                        Type: '%s'\n", this.Type);
      if !isempty(this.dbhandle)
        disp(this.dbhandle);
      endif
    endfunction
  endmethods

  methods
    function msg = get.Message (this)
      if !isempty(this.dbhandle)
        msg = this.dbhandle.Message;
      else
        msg = this.Message;
      endif
    endfunction

    function msg = get.ReadOnly (this)
      if !isempty(this.dbhandle)
        msg = this.dbhandle.ReadOnly;
      else
        msg = this.ReadOnly;
      endif
    endfunction

    function msg = get.AutoCommit (this)
      if !isempty(this.dbhandle)
        msg = this.dbhandle.AutoCommit;
      else
        msg = this.AutoCommit;
      endif
    endfunction

    function set.AutoCommit (this, value)
      
      if !ischar(value) || !(strcmp(value, "on") || strcmp(value, "off"))
        error ("Expected AutoCommit as 'off' or 'on'");
      endif
      if !isempty(this.dbhandle)
        this.dbhandle.AutoCommit = value;
        this.AutoCommit = value;
      endif
    endfunction

    function msg = get.LoginTimeout (this)
      if !isempty(this.dbhandle)
        msg = this.LoginTimeout = this.dbhandle.LoginTimeout;
      else
        msg = this.LoginTimeout;
      endif
    endfunction
 
  endmethods

  methods (Access = private)
    function rdata = _run (this, sqlquery, format)
      if nargin < 3
        format = "table";
      endif
      ## private function to interface to oct file
      data = __odbc_run__(this.dbhandle, sqlquery);
      if nargout > 0
        rdata = format_data(this, data, format);
      endif
    endfunction

    function rdata = format_data(this, data, format="table")
      if strcmp(format, "table")
        # create table ?
        if exist ("struct2table") != 0
          rdata = struct2table(data);
        elseif exist ("struct2dbtable") != 0
          # sqlite provides a dbtable
          rdata = struct2dbtable(data);
        else
          rdata = data;
        endif
      elseif strcmp(format, "structure")
        rdata = data;
      elseif strcmp(format, "cellarray")
        rdata = struct2cell(data);
      else
        error ("Unknown returnformat '%s'", format);
      endif
 
    endfunction

    function type = calc_type(this, n)
      if iscellstr(n)
        type = "varchar";
      elseif isnumeric(n)
        type = "numeric";
      elseif iscell(n)
        type = "numeric";
        for idx=1:length(n)
          if !isnumeric(n{idx})
            type = "varchar";
          endif
        endfor
      else
        type = "varchar";
      endif
    endfunction

    function y = isinputprop(this, n)
      ## private function to return whether a name is a property name
      known_props = { "drivermanager", "autocommit", "logintimeout", "readonly" };
      y = false;
      if ischar(n)
        if sum(strcmpi(n, known_props)) > 0
          y = true;
        endif
      endif
    endfunction
  endmethods
endclassdef

%!shared dbname, db
%! # test connection, isopen, properties and execute
%! # assumes we have a Sqlite3 driver installed
%! dbname = tempname;
%! db = [];
%! if ispc
%! db = connection(["driver={SQLite3 ODBC Driver};Database=" dbname ';']);
%! else
%! db = connection(["driver=SQLite3;Database=" dbname ';']);
%! endif
%! assert(isopen(db));
%! assert(db.Type, 'ODBC Connection Object');
%! db.execute("CREATE TABLE TestTable (Id INT NOT NULL PRIMARY KEY, Name VARCHAR(255));");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (1, 'Name1');");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (2, 'Name2');");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (3, 'Name3');");
%! db.execute("CREATE TABLE TestX (Id INT NOT NULL PRIMARY KEY, Author VARCHAR(255));");
%! db.execute("INSERT INTO TestX (Id,Author) VALUES (1, 'Author1');");

%!xtest
%! # test sqlread - using structure return format to ensure we know what we are getting
%! tbl = db.sqlread("TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [3 2]);
%! tbl = db.sqlread("TestTable", "MaxRows", 1, "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [1 2]);
%! filter = rowfilter("Id") > 1;
%! tbl = db.sqlread("TestTable", "RowFilter", filter, "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [2 2]);

%!xtest
%! # test fetch
%! tbl = db.fetch("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [3 2]);
%! tbl = db.fetch("SELECT * FROM TestTable", "MaxRows", 1, "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [1 2]);
%! filter = rowfilter("Id") > '1';
%! tbl = db.fetch("SELECT * FROM TestTable", "RowFilter", filter, "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [2 2]);

%!xtest
%! # test select
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [3 2]);
%! tbl = db.select("SELECT * FROM TestTable", "MaxRows", 1, "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [1 2]);

%!xtest
%! t = struct("Id", [1;2], "Name", ['Name1';'Name2']);
%! sqlwrite(db, "Test1", t);
%! tbl = sqlread(db , "Test1", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [2 2]);

%!xtest
%! # write no data but have columns
%! t = struct("Id", [], "Name", []);
%! sqlwrite(db, "Testnodata", t);
%! tbl = sqlread(db , "Testnodata", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [2 0]);

%!xtest
%! # test sqlupdate
%! tbl = db.select("SELECT * FROM TestTable WHERE Id=1");
%! assert(tbl.Name{1}, "Name1");
%! rf = rowfilter("Id");
%! rf = (rf.Id == 1);
%! data = struct("Name", {'Name11'});
%! db.sqlupdate("TestTable", data, rf);
%! tbl = db.select("SELECT * FROM TestTable WHERE Id=1");
%! assert(tbl.Name{1}, "Name11");

%!xtest
%! # test update
%! tbl = db.select("SELECT * FROM TestTable WHERE Id=2");
%! assert(tbl.Name{1}, "Name2");
%! data = struct("Name", {'Name22'});
%! db.update("TestTable", {"Name"}, data, "WHERE Id=2");
%! tbl = db.select("SELECT * FROM TestTable WHERE Id=2");
%! assert(tbl.Name{1}, "Name22");

%!xtest
%! # test inner join
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 1]);
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "Keys", "Id", "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 1]);
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "Keys", {"Id"}, "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 1]);
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "LeftKeys", "Name", "RightKeys", "Author", "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 0]);
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "LeftKeys", {"Name"}, "RightKeys", {"Author"}, "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 0]);
%! tbl = db.sqlinnerjoin("TestTable", "TestX", "LeftKeys", "Id", "RightKeys", "Id", "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 1]);

%!xtest
%! # test outer join
%! tbl = db.sqlouterjoin("TestTable", "TestX", "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 3]);
%! tbl = db.sqlouterjoin("TestTable", "TestX", "Keys", {"Id"}, "DataReturnFormat", "structure");
%! assert([size(fieldnames(tbl),1), size(tbl.Id,1)], [3 3]);

%!xtest
%! # test executeSQLScript
%! sqlfile = tempname;
%! fd = fopen(sqlfile, "w+t");
%! fprintf(fd, "SELECT * FROM TestTable WHERE Id=1\n");
%! fprintf(fd, "SELECT * FROM TestTable WHERE Id=2\n");
%! fclose(fd);
%! results = db.executeSQLScript(sqlfile);
%! assert(isstruct(results));
%! assert(fieldnames(results), {'SQLQuery'; 'Data'; 'Message'});
%! assert(results(1).SQLQuery, "SELECT * FROM TestTable WHERE Id=1");
%! delete(sqlfile);

%!xtest
%! # test AutoCommit
%! assert(db.AutoCommit, 'on');
%! db.AutoCommit = 'off';
%! assert(db.AutoCommit, 'off');
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [3 2]);
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (4, 'Name4');");
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [4 2]);
%! rollback(db);
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [3 2]);
%!
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (4, 'Name4');");
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [4 2]);
%! commit(db);
%! tbl = db.select("SELECT * FROM TestTable", "DataReturnFormat", "structure");
%! assert(size(fieldnames(tbl),1), size(tbl.Id,1), [4 2]);
%! db.AutoCommit = 'off';

%!test
%! # test close
%! if !isempty(db)
%!   close(db);
%!   assert(!isopen(db));
%! endif
%! delete(dbname);

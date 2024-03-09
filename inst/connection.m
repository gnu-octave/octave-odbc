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
  ## Connection class for a odbc databse connection
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
      ## REturn true if ODCB connection is open
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
    # sqlinnerjoin
    # sqlouterjoin
   
    function sqlwrite (this, tablename, data, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {} sqlwrite (@var{db}, @var{tablename}, @var{data})
      ## @deftypefnx {} {} sqlwrite (@var{db}, @var{tablename}, @var{data}, @var{columntypes})
      ## @deftypefnx {} {} sqlwrite (@var{db}, @var{tablename}, @var{data}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Insert rows of data into a table.
      ##
      ## Insert rows of data into a sqlite database table.
      ## If the table does not exist it will be created, using the ColumnType property if available
      ## otherwise, the type of input data will be used to determine field types.
      ##
      ## @subsubheading Inputs
      ## @table @asis
      ## @item @var{db}
      ## Previously created octave_sqlite object
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

        if size(coltypes) != size(cols)
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
             v = ['"' v '"'];
          endif
          values = [values v];

        endfor

        if idx > 1
          sql = [sql ",\n"];
        endif
        sql = [sql "(" values ")"];

      endfor

      # create table if ne need to ?
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
      tsql = [tsql ")"];

      execute(this, tsql);

      execute(this, sql);

    endfunction
   
    function results = executeSQLScript (this, filename, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{results} =} executeSQLScript (@var{conn}, @var{scriptname})
      ## Run statements from a script file
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
            t = fetch(this, l, varargin{:})
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
      ## Perform SQL query @var{query}, and return result
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
      ## Perform SQL query @var{query}, and return result
      ## @end deftypefn

      # TODO: verify statement is SELECT ... ?
      data = fetch(this, sqlquery, varargin{:});
    endfunction

    function execute (this, sqlquery)
      ## -*- texinfo -*-
      ## @deftypefn {} {} execute (@var{conn}, @var{query})
      ## Perform SQL query @var{query}, that does not return result
      ## @end deftypefn
      _run(this, sqlquery);
    endfunction

    function data = sqlread (this, tablename, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {@var{data} =} sqlread (@var{conn}, @var{tablename})
      ## @deftypefnx {} {@var{data} =} sqlread (@var{conn}, @var{tablename}, @var{propertryname}, @var{propertyvalue})
      ## Read data from table @var{tablename}
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
      ## Make permanant changes to the database.
      ## @end deftypefn
      _run(this, "COMMIT");
    endfunction

    function rollback (this)
      ## -*- texinfo -*-
      ## @deftypefn {} {} rollback (@var{conn})
      ## Rollback changes to the database.
      ## @end deftypefn
      _run(this, "ROLLBACK");
    endfunction

    function update(conn,tablename,colnames,data,whereclause)
      ## -*- texinfo -*-
      ## @deftypefn {} {} update (@var{conn}, @var{tablename}, @var{colnames}, @var{data}, @var{whereclause})
      ## Update columns in database.
      ## @end deftypefn
 
      sqlquery = "";
    endfunction

    function sqlupdate(conn,tablename, data, filter, varargin)
      ## -*- texinfo -*-
      ## @deftypefn {} {} sqlupdate (@var{db}, @var{tablename}, @var{data}, @var{filter})
      ## @deftypefnx {} {} sqlupdate (@var{db}, @var{tablename}, @var{data}, @var{filter}, @var{propertyname}, @var{propertyvalue} @dots{})
      ## Update rows of data in database.
      ## @end deftypefn
 
      sqlquery = "";
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
        this.Message = this.dbhandle.Message;
      endif
      msg = this.Message;
    endfunction

    function msg = get.ReadOnly (this)
      if !isempty(this.dbhandle)
        this.ReadOnly = this.dbhandle.ReadOnly;
      endif
      msg = this.ReadOnly;
    endfunction

    function msg = get.AutoCommit (this)
      if !isempty(this.dbhandle)
        this.AutoCommit = this.dbhandle.AutoCommit;
      endif
      msg = this.AutoCommit;
    endfunction

    function set.AutoCommit (this, value)
      
      if !ischar(value) || !(strcmp(value, "on") || strcmp(value, "off"))
        error ("Expected AutoCommit as 'off' or 'on'");
      endif
      if !isempty(this.dbhandle)
        this.dbhandle.AutoCommit = value;
      endif
    endfunction

    function msg = get.LoginTimeout (this)
      if !isempty(this.dbhandle)
        this.LoginTimeout = this.dbhandle.LoginTimeout;
      endif
      msg = this.LoginTimeout;
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
%! dbname = tempname;
%! db = connection(["driver=SQLite3;Database=" dbname ';']);
%! assert(isopen(db));
%! db.execute("CREATE TABLE TestTable (Id INT NOT NULL PRIMARY KEY, Name VARCHAR(255));");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (1, 'Name1');");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (2, 'Name2');");
%! db.execute("INSERT INTO TestTable (Id,Name) VALUES (3, 'Name3');");

%!xtest
%! tbl = db.sqlread("TestTable");
%! assert(size(tbl), [3 2]);
%! tbl = db.sqlread("TestTable", "MaxRows", 1);
%! assert(size(tbl), [1 2]);
%! filter = rowfilter("Id") > 1;
%! tbl = db.sqlread("TestTable", "RowFilter", filter);
%! assert(size(tbl), [2 2]);

%!xtest
%! tbl = db.fetch("SELECT * FROM TestTable");
%! assert(size(tbl), [3 2]);
%! tbl = db.fetch("SELECT * FROM TestTable", "MaxRows", 1);
%! assert(size(tbl), [1 2]);
%! filter = rowfilter("Id") > '1';
%! tbl = db.fetch("SELECT * FROM TestTable", "RowFilter", filter);
%! assert(size(tbl), [2 2]);

%!xtest
%! tbl = db.select("SELECT * FROM TestTable");
%! assert(size(tbl), [3 2]);
%! tbl = db.select("SELECT * FROM TestTable", "MaxRows", 1);
%! assert(size(tbl), [1 2]);

%!xtest
%! t = struct("Id", [1;2], "Name", ['Name1';'Name2']);
%! sqlwrite(db, "Test1", t);
%! tbl = sqlread(db , "Test1");
%! assert(size(tbl), [2 2]);

%!test
%! close(db);
%! delete(dbname);

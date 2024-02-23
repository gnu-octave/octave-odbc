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
    DataSource = ''; # DataSource value
    UserName = '';   # Username
    Message = '';    # Last message from database access
    Type = 'ODBC Connection Object'; # connection type
  endproperties

  properties (SetAccess=public, GetAccess=public)
    AutoCommit = 'on';
    ReadOnly = 'off';
    LoginTimeout = 0;
    # more stuff .....
  endproperties

  properties (Access = private)
    dbhandle = [];
  endproperties

  methods
    # here
    function this = connection (databasename, username, password, varargin)
      ## connection constructor
      this.DataSource = databasename;
      this.UserName = username;

      this.dbhandle = __odbc_create__(databasename, username, password);
    endfunction

    function delete (this)
      ## connection deconstructor
      try
        this.dbhandle = [];
      catch
        # do nothing
      end_try_catch
    endfunction

    function Y = isopen (this)
      ## is database open
      Y = ! isempty(this.dbhandle);
    endfunction

    function close (this)
      ## close database if open
      if !isempty(this.dbhandle)
        __odbc_close__(this.dbhandle);
        this.dbhandle = [];
      endif
      this.Message = "Closed";
    endfunction

    # sqlread
    # sqlupdate
    # executeSQLScript
    # runstoredprocedure
    # sqlinnerjoin
    # sqlouterjoin
    # update
    # sqlwrite
    # commit
    # rollback

    function data = fetch (this, query, varargin)
      ## fetch data from database
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
 
      for idx=1:2:numel(varargin)
        n = varargin{idx};
        v = varargin{idx+1};
        if strcmp(n, "MaxRows")
          maxrows = num2str(v);
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

      data = _run(this, query);
    endfunction

    function data = select (this, sqlquery, varargin)
      ## select data from database
      data = _run(this, sqlquery);
    endfunction

    function execute (this, sqlquery)
      ## execute a sql command that returns no data
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

    function disp(this)
      ## Display information about the database
      
      # TODO: make underlying obj show most (all?) this unless not connected - then show just top part with message
      printf ("  connection with properties:\n");
      printf ("                  DataSource: '%s'\n", this.DataSource);
      printf ("                    UserName: '%s'\n", this.UserName);
      printf ("                     Message: '%s'\n", this.Message);
      printf ("                        Type: '%s'\n", this.Type);
      if !isempty(this.dbhandle)
        disp(this.dbhandle);
      printf (" handle = %d\n", this.dbhandle);
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
  endmethods

  methods (Access = private)
    function rdata = _run (this, sqlquery)
      data = __odbc_run__(this.dbhandle, sqlquery);
      if nargout > 0
        # create table ?
        if exist ("struct2table") != 0
          rdata = struct2table(data);
        elseif exist ("struct2dbtable") != 0
          # sqlite provides a dbtable
          rdata = struct2dbtable(data);
        else
          rdata = data;
        endif
      endif
    endfunction
  endmethods
endclassdef

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

## -*- texinfo -*- 
## @deftypefn {} {@var{conn} =} odbc (@var{dbname}, @var{username}, @var{password})
## @deftypefnx {} {@var{conn} =} odbc (@var{dbname}, @var{username}, @var{password}, @var{propertyname}, @var{propertyvalue} @dots{})
## @deftypefnx {} {@var{conn} =} odbc (@var{dsnconnectstr})
## Create an ODBC database connection
##
## @subsubheading Inputs
## @table @code
## @item @var{dbname}
## ODBC DSN connection name, or connection string
## @item @var{username}
## Username foe connecting to database.
## @item @var{password}
## Password for connecting to database.
## @end table
##
## @subsubheading Outputs
## @table @code
## @item @var{conn}
## A connection object for the connected database
## @end table
##
## @subsubheading Examples
## Open a a preconfigured default database, using blank username and password.
## @example
## @code {
## db = odbc("default", "", "");
## }
## @end example
##
## @seealso{database, connection}
## @end deftypefn

function conn = odbc(databasename, varargin)
  if nargin < 1 || !ischar(databasename)
    error ("Expected databasename or connect string as 1st agument");
  endif

  conn = connection(databasename, varargin{:});

endfunction

%!xtest
%! a = odbc("octave_odbc_test");
%! assert(isopen(a));
%! close(a);

%!xtest
%! t = tempname;
%! if ispc
%!   a = odbc(["driver={SQLite3 ODBC Driver};Database=" t ';']);
%! else
%!   a = odbc(["driver=SQLite3;Database=" t ';']);
%! endif
%! assert(isopen(a));
%! close(a);
%! delete(t);


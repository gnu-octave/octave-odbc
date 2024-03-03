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
## @deftypefn {} {@var{conn} =} database (@var{dbname}, @var{username}, @var{password})
## @deftypefnx {} {@var{conn} =} database (@var{dbname}, @var{username}, @var{password}, @var{propertyname}, @var{propertyvalue} @dots{})
## Create a odbc database connection
##
## @subsubheading Inputs
## @table @code
## @item @var{dbname}
## ODBC DSN connection name, or connection string
## @item @var{username}
## Username for connecting to database.
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
## db = database("default", "", "");
## }
## @end example
##
## @seealso{odbc, connection}
## @end deftypefn

function conn = database(databasename, username, password, varargin)

  conn = odbc(databasename, username, password, varargin{:});

endfunction

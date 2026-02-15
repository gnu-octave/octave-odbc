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
## @deftypefn {} {} configureODBCDataSource ()
## Open the ODBC Datasource Administrator dialog box in Windows or
## ODBCManageDataSources in Unix if available.
##
## @subsubheading Inputs
## None
##
## @subsubheading Outputs
## None
##
## @seealso{listDataSources}
## @end deftypefn

function configureODBCDataSource ()
  if ispc
    system ("odbcad32.exe");
  else
    # in unix, there are several possible programs we could use if installed
    
    bin = file_in_path (getenv ("PATH"), "ODBCManageDataSourcesQ6");
    if isempty(bin)
      bin = file_in_path (getenv ("PATH"), "ODBCManageDataSourcesQ5");
    endif
    if isempty(bin)
      bin = file_in_path (getenv ("PATH"), "ODBCManageDataSourcesQ4");
    endif
    if isempty(bin)
      bin = file_in_path (getenv ("PATH"), "ODBCManageDataSources");
    endif

    if isempty(bin)
      error ("Couldnt find ODBCManageDataSources in path - is unixODBC-gui installed?")
    endif

    system (bin);
  endif
endfunction

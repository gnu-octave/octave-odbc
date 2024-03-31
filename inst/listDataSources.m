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
## @deftypefn {} {@var{src} =} listDataSources ()
## List available odbc datasources
##
## @subsubheading Inputs
## None
##
## @subsubheading Outputs
## @table @code
## @item @var{src}
## A table or cell structure of available data sources. The result contains fields for 
## Name, DriverType and Vendor. 
## @end table
##
## @seealso{odbc, database}
## @end deftypefn

function src = listDataSources ()
  src = __odbc_list__ ();
  if exist ("struct2table") != 0
    src = struct2table(src);
  elseif exist ("struct2dbtable") != 0
    src = struct2dbtable(src);
  endif
endfunction

%!test
%! v = listDataSources ();
%! a = v.Name;
%! a = v.DriverType;
%! a = v.Vendor;

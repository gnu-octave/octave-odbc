## Copyright (C) 2024 John Donoghue
##  
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 3 of the
## License, or (at your option) any later version.
##      
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##      
## You should have received a copy of the GNU General Public License
## along with this program; if not, see
## <http:##www.gnu.org/licenses/>.
          
## -*- texinfo -*-
## @deftypefn {} {} __load_odbc__ ()
## Undocumented internal function of odbc package.
## @end deftypefn
        
## PKG_ADD: __load_odbc__ ();

function __load_odbc__ ()
  # on package load, attempt to load docs
  try
    pkg_dir = fileparts (fullfile (mfilename ("fullpath")));
    doc_file = fullfile (pkg_dir, "doc", "octave-odbc.qch");
    doc_file = strrep (doc_file, '\', '/');
    if exist(doc_file, "file")
      if exist("__event_manager_register_documentation__")
        __event_manager_register_documentation__ (doc_file);
      elseif exist("__event_manager_register_doc__")
        __event_manager_register_doc__ (doc_file);
      endif
    endif
  catch
    # do nothing
  end_try_catch

  try
    # attempt to load tabilicious if can 
    # we are doing this currently to make using tablicious an optional
    # requirement
    x = pkg("list", "tablicious");
    if !isempty(x)
      if x{1}.loaded == 0
        pkg("load", "tablicious");
      endif
    endif
  catch
    # do nothing
  end_try_catch
endfunction

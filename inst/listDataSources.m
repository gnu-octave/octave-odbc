# list data sources
function src = listDataSources ()
  src = __odbc_list__ ();
  if exist ("struct2dbtable") != 0
    src = struct2dbtable(src);
  endif
endfunction

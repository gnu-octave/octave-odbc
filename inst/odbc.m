# create a database connection using odbc

function conn = odbc(databasename, username, password, varargin)

  conn = connection(databasename, username, password, varargin{:});

endfunction

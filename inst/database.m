# create a database connection

function conn = database(databasename, username, password, varargin)

  conn = odbc(databasename, username, password, varargin{:});

endfunction

GNU Octave database functionality using odbc
--------------------------------------------

This is a basic implementation of ODBC functionalty similar to MATLABS
ODCB functionalilty.

## Requirements

### Linux

In linux, the devel package for unixODBC must be installed.

To use the configureODBCDataSource function, ODBCManageDataSources must
be avalable from te Qt odbc packages

### Windows

In Windows, the native odbc interface is used.


### Install and loading

The toolkit can be installed in Octave 7.2+ using the command:

    pkg install -forge odbc

After installation, load the package in order to use it.

    pkg load odbc

**Note:** The package needs to loaded each time Octave is run in order to use the package. 

## Documentation

On newer versions of Octave, on loading the package the documentation will be available in the
Octave documentation pages.

The Documentation is also installed as a pdf in the installed package folder.

Online documentation is also available at
https://gnu-octave.github.io/octave-odbc/

## Inbuilt Tests
In built function test can be run using `pkg test odbc`. It requires the SQLite3 ODBC drivers
to be installed, and an octave_odbc_test DSN to be configured.

## Reporting Bugs

Bugs can be filed on the [issue tracker](https://github.com/gnu-octave/octave-odbc/issues).

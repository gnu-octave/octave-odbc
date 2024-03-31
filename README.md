GNU Octave database functionality using odbc
--------------------------------------------

This is a basic implementation of ODBC functionalty similar to MATLABS
ODCB functionalilty.

In linux, it uses unixODBC, in windows the native odbc interface.

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

## Reporting Bugs

Bugs can be filed on the [issue tracker](https://github.com/gnu-octave/octave-odbc/issues).

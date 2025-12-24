#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#
### Copyright (C) 2022-2024 John Donoghue <john.donoghue@ieee.org>
###
### This program is free software; you can redistribute it and/or
### modify it under the terms of the GNU General Public License as
### published by the Free Software Foundation; either version 3 of the
### License, or (at your option) any later version.
###
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
### General Public License for more details.
###
### You should have received a copy of the GNU General Public License
### along with this program; if not, see
### <http://www.gnu.org/licenses/>.

AC_PREREQ([2.67])
AC_INIT([Octave ODBC], [0.0.5])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIRS([m4])
AH_TOP([#include "undef-ah-octave.h"])

AC_PROG_SED
AC_PROG_GREP

AC_CHECK_TOOL([MKOCTFILE], [mkoctfile], [none])
if [ test "x$MKOCTFILE" = "xnone" ]; then
  AC_MSG_ERROR([*** 'mkoctfile' not found.])
fi
AC_CHECK_TOOL([OCTAVE_CONFIG], [octave-config] ,[])
test -z "$OCTAVE_CONFIG" && OCTAVE_CONFIG=$MKOCTFILE

# try get around possible spaces in the path
if test "X${IGNORE_MINGW_PATH_MODIFICATION}" == "X"; then
  MSYSTEM="${MSYSTEM}"
else
  MSYSTEM="none"
fi

if test "X${IGNORE_MINGW_PATH_MODIFICATION}" == "X"; then
case X$MSYSTEM in
  XMINGW*)
    # try demangle spaces in escaped input strings
    MKOCTFILE=`echo $MKOCTFILE | $SED "s,\\\\\ ,?,g"`
    OCTAVE_CONFIG=`echo $OCTAVE_CONFIG | $SED "s,\\\\\ ,?,g"`
    ;;
  *)
    ;;
esac
fi

CXX=`${MKOCTFILE} -p CXX`
save_CXX="$CXX"
AC_PROG_CXX
AC_PROG_CXXCPP

AC_LANG(C++)

# check can access std c files
AC_CHECK_HEADERS([string.h])

## octave API tests
save_CXX="$CXX"
save_CXXFLAGS="$CXXFLAGS"
save_LIBS="$LIBS"
save_LDFLAGS="$LDFLAGS"

CXX=`${MKOCTFILE} -p CXX`
OCTINCLUDEDIR="${OCTINCLUDEDIR:-`$MKOCTFILE -p OCTINCLUDEDIR`}/.."
OCTLIBDIR=${OCTLIBDIR:-`$MKOCTFILE -p OCTLIBDIR`}

case X$MSYSTEM in
  XMINGW64*)
    OCTAVE_HOME=`${MKOCTFILE} -p OCTAVE_HOME | $SED 's,\\\\,/,g'`
    # change \ to / and replace octave home part with mingw part
    OCTINCLUDEDIR=`echo $OCTINCLUDEDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw64,g"`
    OCTLIBDIR=`echo $OCTLIBDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw64,g"`
    ;;
  XMINGW32*)
    OCTAVE_HOME=`${MKOCTFILE} -p OCTAVE_HOME | $SED 's,\\\\,/,g'`
    # change \ to / and replace octave home part with mingw part
    OCTINCLUDEDIR=`echo $OCTINCLUDEDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw32,g"`
    OCTLIBDIR=`echo $OCTLIBDIR | $SED -e 's,\\\\,/,g -e "s,${OCTAVE_HOME},/mingw32,g"'`
    ;;
  *)
    ;;
esac

CXXFLAGS="-I$OCTINCLUDEDIR $CXXFLAGS"
LDFLAGS="-L$OCTLIBDIR $LDFLAGS"
LIBS="-loctinterp $LIBS"

# includes
AC_CHECK_HEADERS([octave/interpreter.h octave/oct-time.h],
  [],
  [],
  [#include <octave/oct.h>]
)

dnl since we Octave 6+, there are not many types that have changed
OF_OCTAVE_LIST_ALT_SYMS([

[dnl
  [feval],
  [octave::feval],
  [[octave::feval ("date");]],
  [OCTAVE__FEVAL],
  [[#include <octave/parse.h>]],
  [[#include <octave/parse.h>]]
],

[dnl
  [octave_time],
  [octave::sys::time],
  [[octave::sys::time t;]],
  [OCTAVE__TIME],
  [[#include <octave/oct-time.h>]],
  [[#include <octave/oct-time.h>]]
],

[dnl
  [octave_base_value],
  [octave_base_dld_value],
  [[octave_base_dld_value tmp;]],
  [OCTAVE_BASE_CLASS],
  [],
  []
]

],[oct-alt-includes.h])

AC_MSG_CHECKING([for octave_base_value count field])
octave_count_field=count
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   #include <octave/oct.h>
   #ifdef HAVE_CONFIG_H
   #  include "config.h"
   #endif
   class test_base_class : public octave_base_value
   {
   public:
     test_base_class() {}
     ~test_base_class() {}
     void test() { m_count ++; }
     bool is_object (void) const { return true; }
   };
  ]], [
    test_base_class t;  t.is_object();
  ])],
 [octave_count_field=m_count],
 [octave_count_field=count]
)
AC_MSG_RESULT([$octave_count_field])
AC_DEFINE_UNQUOTED([OV_COUNT],$octave_count_field,[octave_base_value ref count field])

CC=$save_CXX
CXXFLAGS=$save_CXXFLAGS
LIBS="$save_LIBS"
LDFLAGS="$save_LDFLAGS"

# Check for Windows
AC_MSG_CHECKING([for windows])
have_windows=no
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   #include <windows.h>
   #ifndef __WIN32__
     #error "Not windows!"
   #endif
  ]], [])],
 [AC_MSG_RESULT([yes])
  have_windows=yes],
 [AC_MSG_RESULT([no])])

if test $have_windows = yes; then
  save_CXXFLAGS=$CXXFLAGS
  CXXFLAGS="$ODBC_CFLAGS $CXXFLAGS"
  AC_CHECK_HEADERS([windows.h],[],[])
  AC_CHECK_HEADERS([sql.h],
   [AC_SEARCH_LIBS([SQLAllocHandle], [odbc32],[],[])],
   [],
   [#ifdef HAVE_WINDOWS_H
    #include <windows.h>
    #endif
    ])

  if test "x$ac_cv_search_sqlallochandle" != "xno"; then
    test "x$ac_cv_search_sqlallochandle" = "xnone required" || ODBC_LIBS="$ac_cv_search_sqlallochandle"
  fi
 
  ODBC_LIBS="$ODBC_LIBS"
  ODBC_CFLAGS="$ODBC_CFLAGS"
  CXXFLAGS=$save_CXXFLAGS
else
 # look for unix odbc 
 AC_CHECK_TOOL([ODBC_CONFIG], [odbc_config], [none])
 if ! [ test "x$ODBC_CONFIG" = "xnone" ]; then
   ODBC_LIBS=`$ODBC_CONFIG --libs`
   ODBC_CFLAGS=`$ODBC_CONFIG --cflags`
 else
   PKG_CHECK_MODULES([ODBC], [odbc])
 fi
fi
AC_SUBST([ODBC_LIBS])
AC_SUBST([ODBC_CFLAGS])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT

---
layout: "default"
permalink: "/functions/19_connectionsqlwrite/"
pkg_name: "odbc"
pkg_version: "0.0.4"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.sqlwrite"
category: "Exporting Data"
func_name: "connection.sqlwrite"
navigation:
- id: "overview"
  name: "Overview"
  url: "/index"
- id: "Functions"
  name: "Function Reference"
  url: "/functions"
- id: "15_ODBCconnection"
  name: "&nbsp;&nbsp;ODBC connection"
  url: "/functions/#15_ODBCconnection"
- id: "14_ImportingData"
  name: "&nbsp;&nbsp;Importing Data"
  url: "/functions/#14_ImportingData"
- id: "14_ExportingData"
  name: "&nbsp;&nbsp;Exporting Data"
  url: "/functions/#14_ExportingData"
- id: "19_DatabaseOperations"
  name: "&nbsp;&nbsp;Database Operations"
  url: "/functions/#19_DatabaseOperations"
- id: "17_SupportFunctions"
  name: "&nbsp;&nbsp;Support Functions"
  url: "/functions/#17_SupportFunctions"
- id: "news"
  name: "News"
  url: "/news"
- id: "manual"
  name: "Manual"
  url: "/manual"
---
<dl class="first-deftypefn def-block">
<dt class="deftypefn def-line" id="index-sqlwrite"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>)</code><a class="copiable-link" href="#index-sqlwrite"></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-sqlwrite-1"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">columntypes</var>)</code><a class="copiable-link" href="#index-sqlwrite-1"></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-sqlwrite-2"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href="#index-sqlwrite-2"></a></span></dt>
<dd><p>Insert rows of data into a table.
</p>
<p>Insert rows of data into a database table.
 If the table does not exist it will be created, using the ColumnType property if available
 otherwise, the type of input data will be used to determine field types.
</p>
<h4 class="subsubheading" id="Inputs"><span>Inputs<a class="copiable-link" href="#Inputs"></a></span></h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database connection object
 </p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of table to write data to
 </p></dd>
<dt><var class="var">data</var></dt>
<dd><p>Table containing data to write to the database. Variables names are expected to match the database.
 </p></dd>
<dt><var class="var">columntypes</var></dt>
<dd><p>Optional cell array of same size as data used if table must be created. The column types may also
 be passed in using the <var class="var">propertyname</var>, <var class="var">propertyvalue</var> syntax.
 </p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>ColumnType</dt>
<dd><p>Optional cell array of same size as the data that may be used
  if the table is created as part of the write operation.
  </p></dd>
</dl>
</dd>
</dl>

<h4 class="subsubheading" id="Outputs"><span>Outputs<a class="copiable-link" href="#Outputs"></a></span></h4>
<p>None
</p>

<p><strong class="strong">See also:</strong> database, odbc, sqlread.
 </p></dd></dl>
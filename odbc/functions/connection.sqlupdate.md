---
layout: "default"
permalink: "/functions/20_connectionsqlupdate/"
pkg_name: "odbc"
pkg_version: "0.0.1"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.sqlupdate"
category: "Database Operations"
func_name: "connection.sqlupdate"
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
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqlupdate"><span class="category-def">: </span><span><strong class="def-name">sqlupdate</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">filter</var>)</code><a class="copiable-link" href='#index-sqlupdate'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlupdate-1"><span class="category-def">: </span><span><strong class="def-name">sqlupdate</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">filter</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-sqlupdate-1'></a></span></dt>
<dd><p>Update rows of data in database.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database connection object
 </p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of table to write data to
 </p></dd>
<dt><var class="var">data</var></dt>
<dd><p>Table containing or struct data to write to the database. Variables names are expected to match the database.
 </p></dd>
<dt><var class="var">filter</var></dt>
<dd><p>A Filter object  or cell array of filter objects used to determine which rows of the table to update.
 </p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>Catalog</dt>
<dd><p>An optional database catalog name.
  </p></dd>
<dt>Schema</dt>
<dd><p>An optional database schema name.
  </p></dd>
</dl>
</dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples">Examples</h4>
<p>Update db where id &gt; 1
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # make a filter to select what to update
 rf = rowfilter({'Id'});
 rf = rf.Id &gt; 1;
 # update name where Id &gt; 1
 t = table(['Name3'], 'VariableNames', {'Name'});
 sqlupdate(db, &quot;Test&quot;, t, rf);
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> update.
 </p></dd></dl>
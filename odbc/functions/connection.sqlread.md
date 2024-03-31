---
layout: "default"
permalink: "/functions/18_connectionsqlread/"
pkg_name: "odbc"
pkg_version: "0.0.1"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.sqlread"
category: "Importing Data"
func_name: "connection.sqlread"
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
<dt class="deftypefn" id="index-sqlread"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlread</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>)</code><a class="copiable-link" href='#index-sqlread'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlread-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlread</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>, <var class="var">propertryname</var>, <var class="var">propertyvalue</var>)</code><a class="copiable-link" href='#index-sqlread-1'></a></span></dt>
<dd><p>Read data from table <var class="var">tablename</var>
</p>
<p>Return rows of data from table <var class="var">tablename</var> in a database.
 This function is the equivalent of running SELECT * FROM <var class="var">table</var>.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database.
 </p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of a table with the database.
 </p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>MaxRows</dt>
<dd><p>Integer value of max number of rows in the query
  </p></dd>
<dt>VariableNamingRule</dt>
<dd><p>String value &rsquo;preserve&rsquo; (default) or &rsquo;modify&rsquo; to flag renaming of variable names (currently ignored)
  </p></dd>
<dt>RowFilter</dt>
<dd><p>rowfilter object to filter results
  </p></dd>
</dl>
</dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<dl class="table">
<dt><var class="var">data</var></dt>
<dd><p>a table containing the query result.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Examples">Examples</h4>
<p>Select all rows of data from a database table
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 # create sql connection to an existing database
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = sqlread(db, 'TestTable');
 </code>
 </pre></div>

<p>Select 5 rows of data from a database table
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = sqlread(db, 'TestTable', &quot;MaxRows&quot;, 5);
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> database, fetch.
 </p></dd></dl>
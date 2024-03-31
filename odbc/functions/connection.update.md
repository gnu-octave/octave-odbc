---
layout: "default"
permalink: "/functions/17_connectionupdate/"
pkg_name: "odbc"
pkg_version: "0.0.1"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.update"
category: "Database Operations"
func_name: "connection.update"
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
<dt class="deftypefn" id="index-update"><span class="category-def">: </span><span><strong class="def-name">update</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>, <var class="var">colnames</var>, <var class="var">data</var>, <var class="var">whereclause</var>)</code><a class="copiable-link" href='#index-update'></a></span></dt>
<dd><p>Update columns in database.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>Previously created database connection object
 </p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of table to write data to
 </p></dd>
<dt><var class="var">colnames</var></dt>
<dd><p>cellstr of column names update. Variables names are expected to match the database.
 </p></dd>
<dt><var class="var">data</var></dt>
<dd><p>Table or struct containing data to write to the database. Column names are expected to be present in the data..
 </p></dd>
<dt><var class="var">whereclause</var></dt>
<dd><p>String WHERE condition to meet for updates.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples">Examples</h4>
<p>Update a row in the database
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # update name where Id &gt; 1
 t = table(['Name3'], 'VariableNames', {'Name'});
 update(db, &quot;Test&quot;, t, &quot;WHERE Id &gt; 1&quot;);
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> sqlupdate.
 </p></dd></dl>
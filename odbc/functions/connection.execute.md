---
layout: "default"
permalink: "/functions/18_connectionexecute/"
pkg_name: "odbc"
pkg_version: "0.0.5"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.execute"
category: "Support Functions"
func_name: "connection.execute"
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
  subitems:
- id: "14_ImportingData"
  name: "&nbsp;&nbsp;Importing Data"
  url: "/functions/#14_ImportingData"
  subitems:
- id: "14_ExportingData"
  name: "&nbsp;&nbsp;Exporting Data"
  url: "/functions/#14_ExportingData"
  subitems:
- id: "19_DatabaseOperations"
  name: "&nbsp;&nbsp;Database Operations"
  url: "/functions/#19_DatabaseOperations"
  subitems:
- id: "17_SupportFunctions"
  name: "&nbsp;&nbsp;Support Functions"
  url: "/functions/#17_SupportFunctions"
  subitems:
- id: "news"
  name: "News"
  url: "/news"
- id: "manual"
  name: "Manual"
  url: "/manual"
---
<dl class="first-deftypefn def-block">
<dt class="deftypefn def-line" id="index-execute"><span class="category-def">: </span><span><strong class="def-name">execute</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>)</code><a class="copiable-link" href="#index-execute"></a></span></dt>
<dd><p>Perform SQL query <var class="var">query</var>, that does not return result
</p>
<h4 class="subsubheading" id="Inputs"><span>Inputs<a class="copiable-link" href="#Inputs"></a></span></h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database connection object
 </p></dd>
<dt><var class="var">sqlquery</var></dt>
<dd><p>A valid non selecting SQL query string
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs"><span>Outputs<a class="copiable-link" href="#Outputs"></a></span></h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples"><span>Examples<a class="copiable-link" href="#Examples"></a></span></h4>
<p>Create a database table and insert a row
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # create table and then insert a row
 execute(db, 'CREATE TABLE Test (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT)');
 execute(db, 'INSERT INTO Test (Name) VALUES (&quot;Line1&quot;)');
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> database, fetch.
 </p></dd></dl>
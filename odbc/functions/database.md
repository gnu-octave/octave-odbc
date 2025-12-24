---
layout: "default"
permalink: "/functions/8_database/"
pkg_name: "odbc"
pkg_version: "0.0.5"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - database"
category: "Support Functions"
func_name: "database"
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
<dt class="deftypefn def-line" id="index-database"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">database</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>)</code><a class="copiable-link" href="#index-database"></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-database-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">database</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href="#index-database-1"></a></span></dt>
<dd><p>Create a odbc database connection
</p>
<h4 class="subsubheading" id="Inputs"><span>Inputs<a class="copiable-link" href="#Inputs"></a></span></h4>
<dl class="table">
<dt><code class="code"><var class="var">dbname</var></code></dt>
<dd><p>ODBC DSN connection name, or connection string
 </p></dd>
<dt><code class="code"><var class="var">username</var></code></dt>
<dd><p>Username for connecting to database.
 </p></dd>
<dt><code class="code"><var class="var">password</var></code></dt>
<dd><p>Password for connecting to database.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs"><span>Outputs<a class="copiable-link" href="#Outputs"></a></span></h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>A connection object for the connected database
 </p></dd>
</dl>

<h4 class="subsubheading" id="Examples"><span>Examples<a class="copiable-link" href="#Examples"></a></span></h4>
<p>Open a a preconfigured default database, using blank username and password.
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> odbc, connection.
 </p></dd></dl>
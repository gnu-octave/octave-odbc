---
layout: "default"
permalink: "/functions/4_odbc/"
pkg_name: "odbc"
pkg_version: "0.0.1"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - odbc"
category: "ODBC connection"
func_name: "odbc"
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
<dt class="deftypefn" id="index-odbc"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>)</code><a class="copiable-link" href='#index-odbc'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-odbc-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-odbc-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-odbc-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dsnconnectstr</var>)</code><a class="copiable-link" href='#index-odbc-2'></a></span></dt>
<dd><p>Create an ODBC database connection
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">dbname</var></code></dt>
<dd><p>ODBC DSN connection name, or connection string
 </p></dd>
<dt><code class="code"><var class="var">username</var></code></dt>
<dd><p>Username foe connecting to database.
 </p></dd>
<dt><code class="code"><var class="var">password</var></code></dt>
<dd><p>Password for connecting to database.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>A connection object for the connected database
 </p></dd>
</dl>

<h4 class="subsubheading" id="Examples">Examples</h4>
<p>Open a a preconfigured default database, using blank username and password.
 </p><div class="example">
<pre class="example-preformatted"> <code class="code">
 db = odbc(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 </code>
 </pre></div>


<p><strong class="strong">See also:</strong> database, connection.
 </p></dd></dl>
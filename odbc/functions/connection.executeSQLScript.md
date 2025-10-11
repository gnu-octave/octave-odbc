---
layout: "default"
permalink: "/functions/27_connectionexecuteSQLScript/"
pkg_name: "odbc"
pkg_version: "0.0.4"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.executeSQLScript"
category: "Importing Data"
func_name: "connection.executeSQLScript"
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
<dt class="deftypefn def-line" id="index-executeSQLScript"><span class="category-def">: </span><span><code class="def-type"><var class="var">results</var> =</code> <strong class="def-name">executeSQLScript</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">scriptname</var>)</code><a class="copiable-link" href="#index-executeSQLScript"></a></span></dt>
<dd><p>Run statements from a script file
</p> 
<h4 class="subsubheading" id="Inputs"><span>Inputs<a class="copiable-link" href="#Inputs"></a></span></h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>ODBC connection object
 </p></dd>
<dt><code class="code"><var class="var">scriptname</var></code></dt>
<dd><p>Filename to read statements from. NOTE: currently the file is expected to contain one statement per line.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs"><span>Outputs<a class="copiable-link" href="#Outputs"></a></span></h4>
<dl class="table">
<dt><code class="code"><var class="var">results</var></code></dt>
<dd><p>A struct with fields SQLQuery, Data and Message for each SQL statement in the file.
 </p></dd>
</dl>

</dd></dl>
---
layout: "default"
permalink: "/functions/10_connection/"
pkg_name: "odbc"
pkg_version: "0.0.5"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection"
category: "Support Functions"
func_name: "connection"
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
<dl class="first-deftp def-block">
<dt class="deftp def-line" id="index-connection"><span class="category-def">Class: </span><span><strong class="def-name">connection</strong><a class="copiable-link" href="#index-connection"></a></span></dt>
<dd><p>Connection class for a ODBC database connection
 </p><h4 class="subsubheading" id="Object-Properties"><span>Object Properties<a class="copiable-link" href="#Object-Properties"></a></span></h4>
<dl class="table">
<dt>DataSource</dt>
<dd><p>Datasource value as passed during creation
 </p></dd>
<dt>UserName</dt>
<dd><p>Username value as passed during creation
 </p></dd>
<dt>Password</dt>
<dd><p>Password value as passed during creation
 </p></dd>
<dt>Message</dt>
<dd><p>Readonly last error message
 </p></dd>
<dt>Type</dt>
<dd><p>&rsquo;ODBC Connection Object&rsquo;
 </p></dd>
<dt>ReadOnly</dt>
<dd><p>Boolean for readonly access passed during creation
 </p></dd>
<dt>AutoCommit</dt>
<dd><p>Boolean for control of commit to database
 </p></dd>
<dt>LoginTimeout</dt>
<dd><p>Number of seconds for a login timeout
 </p></dd>
</dl>

<p>Class is created using the odbc or database function.
 </p>
<p><strong class="strong">See also:</strong> odbc, database.
 </p></dd></dl>
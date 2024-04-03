---
layout: "default"
permalink: "/functions/15_listDataSources/"
pkg_name: "odbc"
pkg_version: "0.0.2"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - listDataSources"
category: "ODBC connection"
func_name: "listDataSources"
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
<dt class="deftypefn" id="index-listDataSources"><span class="category-def">: </span><span><code class="def-type"><var class="var">src</var> =</code> <strong class="def-name">listDataSources</strong> <code class="def-code-arguments">()</code><a class="copiable-link" href='#index-listDataSources'></a></span></dt>
<dd><p>List available odbc datasources
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Outputs">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">src</var></code></dt>
<dd><p>A table or cell structure of available data sources. The result contains fields for 
 Name, DriverType and Vendor. 
 </p></dd>
</dl>


<p><strong class="strong">See also:</strong> odbc, database.
 </p></dd></dl>
---
layout: "default"
permalink: "/functions/15_listDataSources/"
pkg_name: "odbc"
pkg_version: "0.0.5"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - listDataSources"
category: "Support Functions"
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
<dt class="deftypefn def-line" id="index-listDataSources"><span class="category-def">: </span><span><code class="def-type"><var class="var">src</var> =</code> <strong class="def-name">listDataSources</strong> <code class="def-code-arguments">()</code><a class="copiable-link" href="#index-listDataSources"></a></span></dt>
<dd><p>List available odbc datasources
</p>
<h4 class="subsubheading" id="Inputs"><span>Inputs<a class="copiable-link" href="#Inputs"></a></span></h4>
<p>None
</p>
<h4 class="subsubheading" id="Outputs"><span>Outputs<a class="copiable-link" href="#Outputs"></a></span></h4>
<dl class="table">
<dt><code class="code"><var class="var">src</var></code></dt>
<dd><p>A table or cell structure of available data sources. The result contains fields for 
 Name, DriverType and Vendor. 
 </p></dd>
</dl>


<p><strong class="strong">See also:</strong> odbc, database.
 </p></dd></dl>
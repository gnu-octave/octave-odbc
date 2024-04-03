---
layout: "default"
permalink: "/functions/9_rowfilter/"
pkg_name: "odbc"
pkg_version: "0.0.2"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - rowfilter"
category: "Support Functions"
func_name: "rowfilter"
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
<dt class="deftypefn" id="index-rowfilter_0028C_0029"><span class="category-def">: </span><span><code class="def-type"><var class="var">rowfilt</var> =</code> <strong class="def-name">rowfilter(<var class="var">C</var>)</strong><a class="copiable-link" href='#index-rowfilter_0028C_0029'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-rowfilter_0028T_0029"><span class="category-def">: </span><span><code class="def-type"><var class="var">rowfilt</var> =</code> <strong class="def-name">rowfilter(<var class="var">T</var>)</strong><a class="copiable-link" href='#index-rowfilter_0028T_0029'></a></span></dt>
<dd><p>Create an unconstrained rowfilter object with columns names.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><var class="var">C</var></dt>
<dd><p>A column name, cell array of column names.
 </p></dd>
<dt><var class="var">T</var></dt>
<dd><p>A table to use for column names.
 </p></dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<dl class="table">
<dt><var class="var">rowfilt</var></dt>
<dd><p>a rowfilter object
 </p></dd>
</dl>

<h4 class="subsubheading" id="Object-Properties">Object Properties</h4>
<p>Object properties are the names of the columns on creation of the filter.
</p>
<p>Constraints can be set on a specific field of the filter by setting a
 comparison value for the variable name.
</p>
<h4 class="subsubheading" id="Examples">Examples</h4>
<div class="example">
<pre class="example-preformatted"> <code class="code">
 # create a rowfilter with 2 columns
 rf = rowfilter({'Column1', 'Column2'});
 # add a constraint for Column1 &gt; 10
 rfc = rf.Column1 &gt; 10
 </code>
 </pre></div>

</dd></dl>
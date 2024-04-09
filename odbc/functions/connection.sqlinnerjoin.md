---
layout: "default"
permalink: "/functions/23_connectionsqlinnerjoin/"
pkg_name: "odbc"
pkg_version: "0.0.3"
pkg_description: "Basic Octave implementation for ODBC database functionality"
title: "Odbc Toolkit - connection.sqlinnerjoin"
category: "Importing Data"
func_name: "connection.sqlinnerjoin"
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
<dt class="deftypefn" id="index-sqlinnerjoin"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>)</code><a class="copiable-link" href='#index-sqlinnerjoin'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlinnerjoin-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;Keys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlinnerjoin-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlinnerjoin-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;LeftKeys&quot;, <var class="var">keys</var>, &quot;RightKeys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlinnerjoin-2'></a></span></dt>
<dd><p>Perform an innerjoin on two tables.
</p> 
<p>Performs an innerjoin equivalent to &rsquo;SELECT * from lefttable INNER JOIN righttable ON lefttable.key = rightable.key&rsquo;.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created connection object
 </p></dd>
<dt><var class="var">lefttablename</var></dt>
<dd><p>Name of lefthand table
 </p></dd>
<dt><var class="var">righttablename</var></dt>
<dd><p>Name of righthand table
 </p></dd>
<dt><var class="var">keys</var></dt>
<dd><p>A string or cellstring of column names to join against.
 If specified as Keys, the names will be used on lefthand and rightside of the join.
 If specified as LeftKeys and RightKeys, keys will be used separately for each side of the table.
 If no keys are provided, common named columns will be matched between the tables.
 </p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>Property name/value pairs where known properties are:
  </p><dl class="table">
<dt>MaxRows</dt>
<dd><p>Max number of rows to return.
  </p></dd>
<dt>DataReturnFormat</dt>
<dd><p>Format to return data in (&rsquo;table&rsquo;, &rsquo;structure&rsquo;, &rsquo;cellarray&rsquo;)
  </p></dd>
</dl>
</dd>
</dl>

<h4 class="subsubheading" id="Outputs">Outputs</h4>
<p>None
</p>

<p><strong class="strong">See also:</strong> database, odbc, fetch, sqlouterjoin.
 </p></dd></dl>
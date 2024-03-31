---
layout: "default"
permalink: "/manual/"
title: "Odbc Toolkit - Manual"
pkg_name: "odbc"
version: "0.0.1"
description: "Basic Octave implementation for ODBC database functionality"
navigation:
- id: "overview"
  name: "Overview"
  url: "/index"
- id: "Functions"
  name: "Function Reference"
  url: "/functions"
- id: "news"
  name: "News"
  url: "/news"
- id: "manual"
  name: "Manual"
- id: "Installing-and-loading-1"
  name: "&nbsp;&nbsp; Installing and loading"
  url: "/manual/#Installing-and-loading-1"
- id: "Basic-Usage-Overview-1"
  name: "&nbsp;&nbsp; Basic Usage Overview"
  url: "/manual/#Basic-Usage-Overview-1"
- id: "Function-Reference-1"
  name: "&nbsp;&nbsp; Function Reference"
  url: "/manual/#Function-Reference-1"
---
<div class="top-level-extent" id="Top">
<div class="nav-panel">
<p>
Next: <a href="#Installing-and-loading" accesskey="n" rel="next">Installing and loading</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h1 class="top" id="Introduction">Introduction</h1>
<p>The Octave ODBC toolkit is a set of ODBC routines for GNU Octave
</p>
<div class="element-contents" id="SEC_Contents">
<h2 class="contents-heading">Table of Contents</h2>
<div class="contents">
<ul class="toc-numbered-mark">
  <li><a id="toc-Installing-and-loading-1" href="#Installing-and-loading">1 Installing and loading</a>
  <ul class="toc-numbered-mark">
    <li><a id="toc-Online-Direct-install" href="#Online-Direct-install">1.1 Online Direct install</a></li>
    <li><a id="toc-Off_002dline-install" href="#Off_002dline-install">1.2 Off-line install</a></li>
    <li><a id="toc-Loading" href="#Loading">1.3 Loading</a></li>
  </ul></li>
  <li><a id="toc-Basic-Usage-Overview-1" href="#Basic-Usage-Overview">2 Basic Usage Overview</a>
  <ul class="toc-numbered-mark">
    <li><a id="toc-Database-Configuration" href="#Database-Configuration">2.1 Database Configuration</a></li>
    <li><a id="toc-Database-Connection" href="#Database-Connection">2.2 Database Connection</a></li>
    <li><a id="toc-Close-the-database" href="#Close-the-database">2.3 Close the database</a></li>
  </ul></li>
  <li><a id="toc-Function-Reference-1" href="#Function-Reference">3 Function Reference</a>
  <ul class="toc-numbered-mark">
    <li><a id="toc-ODBC-connection-1" href="#ODBC-connection">3.1 ODBC connection</a>
    <ul class="toc-numbered-mark">
      <li><a id="toc-configureODBCDataSource" href="#configureODBCDataSource">3.1.1 configureODBCDataSource</a></li>
      <li><a id="toc-connection" href="#connection">3.1.2 connection</a></li>
      <li><a id="toc-database" href="#database">3.1.3 database</a></li>
      <li><a id="toc-listDataSources" href="#listDataSources">3.1.4 listDataSources</a></li>
      <li><a id="toc-odbc" href="#odbc">3.1.5 odbc</a></li>
    </ul></li>
    <li><a id="toc-Importing-Data-1" href="#Importing-Data">3.2 Importing Data</a>
    <ul class="toc-numbered-mark">
      <li><a id="toc-executeSQLScript" href="#executeSQLScript">3.2.1 executeSQLScript</a></li>
      <li><a id="toc-fetch" href="#fetch">3.2.2 fetch</a></li>
      <li><a id="toc-select" href="#select">3.2.3 select</a></li>
      <li><a id="toc-sqlinnerjoin" href="#sqlinnerjoin">3.2.4 sqlinnerjoin</a></li>
      <li><a id="toc-sqlouterjoin" href="#sqlouterjoin">3.2.5 sqlouterjoin</a></li>
      <li><a id="toc-sqlread" href="#sqlread">3.2.6 sqlread</a></li>
    </ul></li>
    <li><a id="toc-Exporting-Data-1" href="#Exporting-Data">3.3 Exporting Data</a>
    <ul class="toc-numbered-mark">
      <li><a id="toc-sqlwrite" href="#sqlwrite">3.3.1 sqlwrite</a></li>
    </ul></li>
    <li><a id="toc-Database-Operations-1" href="#Database-Operations">3.4 Database Operations</a>
    <ul class="toc-numbered-mark">
      <li><a id="toc-commit" href="#commit">3.4.1 commit</a></li>
      <li><a id="toc-execute" href="#execute">3.4.2 execute</a></li>
      <li><a id="toc-rollback" href="#rollback">3.4.3 rollback</a></li>
      <li><a id="toc-sqlupdate" href="#sqlupdate">3.4.4 sqlupdate</a></li>
      <li><a id="toc-update" href="#update">3.4.5 update</a></li>
    </ul></li>
    <li><a id="toc-Support-Functions-1" href="#Support-Functions">3.5 Support Functions</a>
    <ul class="toc-numbered-mark">
      <li><a id="toc-rowfilter" href="#rowfilter">3.5.1 rowfilter</a></li>
    </ul></li>
  </ul></li>
  <li><a id="toc-GNU-General-Public-License" href="#Copying">Appendix A GNU General Public License</a></li>
  <li><a id="toc-Index-1" href="#Index" rel="index">Index</a></li>
</ul>
</div>
</div>
<hr>
<div class="chapter-level-extent" id="Installing-and-loading">
<div class="nav-panel">
<p>
Next: <a href="#Basic-Usage-Overview" accesskey="n" rel="next">Basic Usage Overview</a>, Previous: <a href="#Top" accesskey="p" rel="prev">Introduction</a>, Up: <a href="#Top" accesskey="u" rel="up">Introduction</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h2 class="chapter" id="Installing-and-loading-1">1 Installing and loading</h2>
<a class="index-entry-id" id="index-Installing-and-loading"></a>
<p>The toolkit must be installed and then loaded to be used.
</p>
<p>It can be installed in <abbr class="acronym">GNU</abbr> Octave directly from the website,
or can be installed in an off-line mode via a downloaded tarball.
</p>
<p>The toolkit has a dependency on the unixODBC library in Linux, so it must be installed in order
to successfully install the toolkit.
</p>
<p>In Microsoft Windows, it uses the native odbc library.
</p>
<p>The toolkit must be then be loaded once per each <abbr class="acronym">GNU</abbr> Octave session in order to use its functionality.
</p>
<ul class="mini-toc">
<li><a href="#Online-Direct-install" accesskey="1">Online Direct install</a></li>
<li><a href="#Off_002dline-install" accesskey="2">Off-line install</a></li>
<li><a href="#Loading" accesskey="3">Loading</a></li>
</ul>
<div class="section-level-extent" id="Online-Direct-install">
<h3 class="section">1.1 Online Direct install</h3>
<a class="index-entry-id" id="index-Online-install"></a>
<p>With an internet connection available, the octave ODBC package can be installed from
the octave-odbc website using the following command within <abbr class="acronym">GNU</abbr> Octave:
</p>
<div class="example">
<pre class="example-preformatted">pkg install https://github.com/gnu-octave/octave-odbc/releases/download/v0.0.1/octave-odbc-0.0.1.tar.gz
</pre></div>
<p>On Octave 7.2 and later, the package can be installed using the following command within
<abbr class="acronym">GNU</abbr> Octave:
</p>
<div class="example">
<pre class="example-preformatted">pkg install -forge odbc
</pre></div>
<p>The latest released version of the toolkit will be downloaded and installed.
</p>
</div>
<div class="section-level-extent" id="Off_002dline-install">
<h3 class="section">1.2 Off-line install</h3>
<a class="index-entry-id" id="index-Off_002dline-install"></a>
<p>With the toolkit package already downloaded, and in the current directory when running
<abbr class="acronym">GNU</abbr> Octave, the package can be installed using the following command within <abbr class="acronym">GNU</abbr> Octave:
</p>
<div class="example">
<pre class="example-preformatted">pkg install octave-odbc-0.0.1.tar.gz
</pre></div>
</div>
<div class="section-level-extent" id="Loading">
<h3 class="section">1.3 Loading</h3>
<a class="index-entry-id" id="index-Loading"></a>
<p>Regardless of the method of installing the toolkit, in order to use its functions,
the toolkit must be loaded using the pkg load command:
</p>
<div class="example">
<pre class="example-preformatted">pkg load odbc
</pre></div>
<p>The toolkit must be loaded on each <abbr class="acronym">GNU</abbr> Octave session.
</p>
<p>The toolkit will also load the tablicious toolkit if available to provide table support.
</p>
<hr>
</div>
</div>
<div class="chapter-level-extent" id="Basic-Usage-Overview">
<div class="nav-panel">
<p>
Next: <a href="#Function-Reference" accesskey="n" rel="next">Function Reference</a>, Previous: <a href="#Installing-and-loading" accesskey="p" rel="prev">Installing and loading</a>, Up: <a href="#Top" accesskey="u" rel="up">Introduction</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h2 class="chapter" id="Basic-Usage-Overview-1">2 Basic Usage Overview</h2>
<a class="index-entry-id" id="index-Basic-Usage-Overview"></a>
<ul class="mini-toc">
<li><a href="#Database-Configuration" accesskey="1">Database Configuration</a></li>
<li><a href="#Database-Connection" accesskey="2">Database Connection</a></li>
<li><a href="#Close-the-database" accesskey="3">Close the database</a></li>
</ul>
<div class="section-level-extent" id="Database-Configuration">
<h3 class="section">2.1 Database Configuration</h3>
<a class="index-entry-id" id="index-Database-Configuration"></a>
<p>A ODBC driver and datasource must be configured in order to connect to it.
</p>
<p>The known datasources can be displayed by running the command <code class="code">listDataSources</code>
</p>
<p>For Windows ODBC, to modify or add additional datasources. run the command <code class="code">configureODBCDataSource</code> to 
open the system ODBC configraion tool.
</p>
<p>In Linux, configure using the configution files or tools  available for unixODBC.
</p>
</div>
<div class="section-level-extent" id="Database-Connection">
<h3 class="section">2.2 Database Connection</h3>
<a class="index-entry-id" id="index-Database-Connection"></a>
<p>A database can be connected to by using the <code class="code">odbc</code> or <code class="code">database</code> function.
</p>
<p>The datasource name can be either a DSN value as returned from <code class="code">listDataSources</code>
or a DSNless connection string providing driver information to pass to a driver.
</p>
<h4 class="subsubheading" id="Example">Example</h4>
<div class="example">
<pre class="example-preformatted">Connection to MYSQL using DSN
<code class="code">
# connection using DSN
conn = odbc(&quot;MySQL ODBC&quot; ,&quot;username&quot;,&quot;password&quot;)
</code>
</pre></div>
<div class="example">
<pre class="example-preformatted">Connection using DSNless string
<code class="code">
# connection to SQLITE using DSNless string
conn = odbc(&quot;Driver=SQLite3;Database=mytest.db;&quot;, &quot;&quot;,&quot;&quot;)
</code>
</pre></div>
<a class="index-entry-id" id="index-Read-a-table"></a>
<p>To quickly read data from a table, use the sqlread function
</p>
<h4 class="subsubheading" id="Example-1">Example</h4>
<div class="example">
<pre class="example-preformatted"><code class="code">
data = sqlread(conn, &quot;TestTable&quot;)
</code>
</pre></div>
</div>
<div class="section-level-extent" id="Close-the-database">
<h3 class="section">2.3 Close the database</h3>
<a class="index-entry-id" id="index-Close-the-database"></a>
<p>To close the database, use the close function
</p>
<h4 class="subsubheading" id="Example-2">Example</h4>
<div class="example">
<pre class="example-preformatted"><code class="code">
close(conn)
</code>
</pre></div>
<hr>
</div>
</div>
<div class="chapter-level-extent" id="Function-Reference">
<div class="nav-panel">
<p>
Next: <a href="#Copying" accesskey="n" rel="next">GNU General Public License</a>, Previous: <a href="#Basic-Usage-Overview" accesskey="p" rel="prev">Basic Usage Overview</a>, Up: <a href="#Top" accesskey="u" rel="up">Introduction</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h2 class="chapter" id="Function-Reference-1">3 Function Reference</h2>
<a class="index-entry-id" id="index-Function-Reference"></a>
<p>The functions currently available in the toolkit are described below;
</p>
<ul class="mini-toc">
<li><a href="#ODBC-connection" accesskey="1">ODBC connection</a></li>
<li><a href="#Importing-Data" accesskey="2">Importing Data</a></li>
<li><a href="#Exporting-Data" accesskey="3">Exporting Data</a></li>
<li><a href="#Database-Operations" accesskey="4">Database Operations</a></li>
<li><a href="#Support-Functions" accesskey="5">Support Functions</a></li>
</ul>
<hr>
<div class="section-level-extent" id="ODBC-connection">
<div class="nav-panel">
<p>
Next: <a href="#Importing-Data" accesskey="n" rel="next">Importing Data</a>, Up: <a href="#Function-Reference" accesskey="u" rel="up">Function Reference</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h3 class="section" id="ODBC-connection-1">3.1 ODBC connection</h3>
<a class="index-entry-id" id="index-ODBC-connection"></a>
<ul class="mini-toc">
<li><a href="#configureODBCDataSource" accesskey="1">configureODBCDataSource</a></li>
<li><a href="#connection" accesskey="2">connection</a></li>
<li><a href="#database" accesskey="3">database</a></li>
<li><a href="#listDataSources" accesskey="4">listDataSources</a></li>
<li><a href="#odbc" accesskey="5">odbc</a></li>
</ul>
<div class="subsection-level-extent" id="configureODBCDataSource">
<h4 class="subsection">3.1.1 configureODBCDataSource</h4>
<a class="index-entry-id" id="index-configureODBCDataSource"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-configureODBCDataSource-1"><span class="category-def">: </span><span><strong class="def-name">configureODBCDataSource</strong> <code class="def-code-arguments">()</code><a class="copiable-link" href='#index-configureODBCDataSource-1'></a></span></dt>
<dd><p>Open the ODBC Datasource Administrator dialog box in Windows.
</p>
<h4 class="subsubheading" id="Inputs">Inputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Outputs">Outputs</h4>
<p>None
</p>
<p><strong class="strong">See also:</strong> listDataSources.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="connection">
<h4 class="subsection">3.1.2 connection</h4>
<a class="index-entry-id" id="index-connection"></a>
<dl class="first-deftp">
<dt class="deftp" id="index-connection-1"><span class="category-def">Class: </span><span><strong class="def-name">connection</strong><a class="copiable-link" href='#index-connection-1'></a></span></dt>
<dd><p>Connection class for a odbc database connection
</p><h4 class="subsubheading" id="Object-Properties">Object Properties</h4>
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
</div>
<div class="subsection-level-extent" id="database">
<h4 class="subsection">3.1.3 database</h4>
<a class="index-entry-id" id="index-database"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-database-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">database</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>)</code><a class="copiable-link" href='#index-database-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-database-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">database</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-database-2'></a></span></dt>
<dd><p>Create a odbc database connection
</p>
<h4 class="subsubheading" id="Inputs-1">Inputs</h4>
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
<h4 class="subsubheading" id="Outputs-1">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>A connection object for the connected database
</p></dd>
</dl>
<h4 class="subsubheading" id="Examples">Examples</h4>
<p>Open a a preconfigured default database, using blank username and password.
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> odbc, connection.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="listDataSources">
<h4 class="subsection">3.1.4 listDataSources</h4>
<a class="index-entry-id" id="index-listDataSources"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-listDataSources-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">src</var> =</code> <strong class="def-name">listDataSources</strong> <code class="def-code-arguments">()</code><a class="copiable-link" href='#index-listDataSources-1'></a></span></dt>
<dd><p>List available odbc datasources
</p>
<h4 class="subsubheading" id="Inputs-2">Inputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Outputs-2">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">src</var></code></dt>
<dd><p>A table or cell structure of available data sources. The result contains fields for
 Name, DriverType and Vendor.
</p></dd>
</dl>
<p><strong class="strong">See also:</strong> odbc, database.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="odbc">
<h4 class="subsection">3.1.5 odbc</h4>
<a class="index-entry-id" id="index-odbc"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-odbc-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>)</code><a class="copiable-link" href='#index-odbc-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-odbc-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dbname</var>, <var class="var">username</var>, <var class="var">password</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-odbc-2'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-odbc-3"><span class="category-def">: </span><span><code class="def-type"><var class="var">conn</var> =</code> <strong class="def-name">odbc</strong> <code class="def-code-arguments">(<var class="var">dsnconnectstr</var>)</code><a class="copiable-link" href='#index-odbc-3'></a></span></dt>
<dd><p>Create an ODBC database connection
</p>
<h4 class="subsubheading" id="Inputs-3">Inputs</h4>
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
<h4 class="subsubheading" id="Outputs-3">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>A connection object for the connected database
</p></dd>
</dl>
<h4 class="subsubheading" id="Examples-1">Examples</h4>
<p>Open a a preconfigured default database, using blank username and password.
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 db = odbc(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> database, connection.
</p></dd></dl>
<hr>
</div>
</div>
<div class="section-level-extent" id="Importing-Data">
<div class="nav-panel">
<p>
Next: <a href="#Exporting-Data" accesskey="n" rel="next">Exporting Data</a>, Previous: <a href="#ODBC-connection" accesskey="p" rel="prev">ODBC connection</a>, Up: <a href="#Function-Reference" accesskey="u" rel="up">Function Reference</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h3 class="section" id="Importing-Data-1">3.2 Importing Data</h3>
<a class="index-entry-id" id="index-Importing-Data"></a>
<ul class="mini-toc">
<li><a href="#executeSQLScript" accesskey="1">executeSQLScript</a></li>
<li><a href="#fetch" accesskey="2">fetch</a></li>
<li><a href="#select" accesskey="3">select</a></li>
<li><a href="#sqlinnerjoin" accesskey="4">sqlinnerjoin</a></li>
<li><a href="#sqlouterjoin" accesskey="5">sqlouterjoin</a></li>
<li><a href="#sqlread" accesskey="6">sqlread</a></li>
</ul>
<div class="subsection-level-extent" id="executeSQLScript">
<h4 class="subsection">3.2.1 executeSQLScript</h4>
<a class="index-entry-id" id="index-executeSQLScript"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-executeSQLScript-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">results</var> =</code> <strong class="def-name">executeSQLScript</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">scriptname</var>)</code><a class="copiable-link" href='#index-executeSQLScript-1'></a></span></dt>
<dd><p>Run statements from a script file
</p>
<h4 class="subsubheading" id="Inputs-4">Inputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">conn</var></code></dt>
<dd><p>ODBC connection object
</p></dd>
<dt><code class="code"><var class="var">scriptname</var></code></dt>
<dd><p>Filename to read statements from. NOTE: currently the file is expected to contain one statement per line.
</p></dd>
</dl>
<h4 class="subsubheading" id="Outputs-4">Outputs</h4>
<dl class="table">
<dt><code class="code"><var class="var">results</var></code></dt>
<dd><p>A struct with fields SQLQuery, Data and Message for each SAQL statement in the file.
</p></dd>
</dl>
</dd></dl>
</div>
<div class="subsection-level-extent" id="fetch">
<h4 class="subsection">3.2.2 fetch</h4>
<a class="index-entry-id" id="index-fetch"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-fetch-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">fetch</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>)</code><a class="copiable-link" href='#index-fetch-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-fetch-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">fetch</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-fetch-2'></a></span></dt>
<dd><p>Perform SQL query <var class="var">query</var>, and return result
</p><h4 class="subsubheading" id="Inputs-5">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database connection.
</p></dd>
<dt><var class="var">sqlquery</var></dt>
<dd><p>String containing a valid select SQL query.
</p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>MaxRows</dt>
<dd><p>Integer value of max number of rows in the query
  </p></dd>
<dt>VariableNamingRule</dt>
<dd><p>String value &rsquo;preserve&rsquo; (default) or &rsquo;modify&rsquo; to flag renaming of variable names (currently ignored)
  </p></dd>
<dt>RowFilter</dt>
<dd><p>rowfilter object to filter results
  </p></dd>
</dl>
</dd>
</dl>
<h4 class="subsubheading" id="Outputs-5">Outputs</h4>
<dl class="table">
<dt><var class="var">data</var></dt>
<dd><p>a table containing the query result.
</p></dd>
</dl>
<h4 class="subsubheading" id="Examples-2">Examples</h4>
<p>Select all rows of data from a database tables
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = fetch(db, 'SELECT * FROM TestTable');
 </code>
</pre></div>
<p>Select 5 rows of data from a database tables
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = fetch(db, 'SELECT * FROM TestTable', &quot;MaxRows&quot;, 5);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> database, connection.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="select">
<h4 class="subsection">3.2.3 select</h4>
<a class="index-entry-id" id="index-select"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-select-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">select</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>)</code><a class="copiable-link" href='#index-select-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-select-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">select</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-select-2'></a></span></dt>
<dd><p>Perform SQL query <var class="var">query</var>, and return result
</p><h4 class="subsubheading" id="Inputs-6">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database connection.
</p></dd>
<dt><var class="var">query</var></dt>
<dd><p>String containing a valid select SQL query.
</p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>MaxRows</dt>
<dd><p>Integer value of max number of rows in the query
  </p></dd>
<dt>VariableNamingRule</dt>
<dd><p>String value &rsquo;preserve&rsquo; (default) or &rsquo;modify&rsquo; to flag renaming of variable names (currently ignored)
  </p></dd>
<dt>RowFilter</dt>
<dd><p>rowfilter object to filter results
  </p></dd>
</dl>
</dd>
</dl>
<h4 class="subsubheading" id="Outputs-6">Outputs</h4>
<dl class="table">
<dt><var class="var">data</var></dt>
<dd><p>a table containing the query result.
</p></dd>
</dl>
<h4 class="subsubheading" id="Examples-3">Examples</h4>
<p>Select all rows of data from a database tables
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = fetch(db, 'SELECT * FROM TestTable');
 </code>
</pre></div>
<p>Select 5 rows of data from a database tables
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = fetch(db, 'SELECT * FROM TestTable', &quot;MaxRows&quot;, 5);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> database, connection.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="sqlinnerjoin">
<h4 class="subsection">3.2.4 sqlinnerjoin</h4>
<a class="index-entry-id" id="index-sqlinnerjoin"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqlinnerjoin-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>)</code><a class="copiable-link" href='#index-sqlinnerjoin-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlinnerjoin-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;Keys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlinnerjoin-2'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlinnerjoin-3"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlinnerjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;LeftKeys&quot;, <var class="var">keys</var>, &quot;RightKeys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlinnerjoin-3'></a></span></dt>
<dd><p>Perform an innerjoin on two tables.
</p>
<p>Performs an innerjoin equivalent to &rsquo;SELECT * from lefttable INNER JOIN righttable ON lefttable.key = rightable.key&rsquo;.
</p>
<h4 class="subsubheading" id="Inputs-7">Inputs</h4>
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
<dd><p>property name/value pairs where known properties are:
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
<h4 class="subsubheading" id="Outputs-7">Outputs</h4>
<p>None
</p>
<p><strong class="strong">See also:</strong> database, odbc, fetch, sqlouterjoin.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="sqlouterjoin">
<h4 class="subsection">3.2.5 sqlouterjoin</h4>
<a class="index-entry-id" id="index-sqlouterjoin"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqloutjoin"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqloutjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>)</code><a class="copiable-link" href='#index-sqloutjoin'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlouterjoin-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlouterjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;Keys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlouterjoin-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlouterjoin-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlouterjoin</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">lefttablename</var>, <var class="var">righttablename</var>, &quot;LeftKeys&quot;, <var class="var">keys</var>, &quot;RightKeys&quot;, <var class="var">keys</var>, &hellip;)</code><a class="copiable-link" href='#index-sqlouterjoin-2'></a></span></dt>
<dd><p>Perform an outerjoin on two tables.
</p>
<p>Performs an outerjoin equivalent to &rsquo;SELECT * from lefttable OUTER JOIN righttable ON lefttable.key = rightable.key&rsquo;.
</p>
<h4 class="subsubheading" id="Inputs-8">Inputs</h4>
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
<dd><p>property name/value pairs where known properties are:
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
<h4 class="subsubheading" id="Outputs-8">Outputs</h4>
<p>None
</p>
<p><strong class="strong">See also:</strong> database, odbc, fetch, sqlinnerjoin.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="sqlread">
<h4 class="subsection">3.2.6 sqlread</h4>
<a class="index-entry-id" id="index-sqlread"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqlread-1"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlread</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>)</code><a class="copiable-link" href='#index-sqlread-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlread-2"><span class="category-def">: </span><span><code class="def-type"><var class="var">data</var> =</code> <strong class="def-name">sqlread</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>, <var class="var">propertryname</var>, <var class="var">propertyvalue</var>)</code><a class="copiable-link" href='#index-sqlread-2'></a></span></dt>
<dd><p>Read data from table <var class="var">tablename</var>
</p>
<p>Return rows of data from table <var class="var">tablename</var> in a database.
 This function is the equivalent of running SELECT * FROM <var class="var">table</var>.
</p>
<h4 class="subsubheading" id="Inputs-9">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database.
</p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of a table with the database.
</p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>MaxRows</dt>
<dd><p>Integer value of max number of rows in the query
  </p></dd>
<dt>VariableNamingRule</dt>
<dd><p>String value &rsquo;preserve&rsquo; (default) or &rsquo;modify&rsquo; to flag renaming of variable names (currently ignored)
  </p></dd>
<dt>RowFilter</dt>
<dd><p>rowfilter object to filter results
  </p></dd>
</dl>
</dd>
</dl>
<h4 class="subsubheading" id="Outputs-9">Outputs</h4>
<dl class="table">
<dt><var class="var">data</var></dt>
<dd><p>a table containing the query result.
</p></dd>
</dl>
<h4 class="subsubheading" id="Examples-4">Examples</h4>
<p>Select all rows of data from a database table
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection to an existing database
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = sqlread(db, 'TestTable');
 </code>
</pre></div>
<p>Select 5 rows of data from a database table
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 data = sqlread(db, 'TestTable', &quot;MaxRows&quot;, 5);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> database, fetch.
</p></dd></dl>
<hr>
</div>
</div>
<div class="section-level-extent" id="Exporting-Data">
<div class="nav-panel">
<p>
Next: <a href="#Database-Operations" accesskey="n" rel="next">Database Operations</a>, Previous: <a href="#Importing-Data" accesskey="p" rel="prev">Importing Data</a>, Up: <a href="#Function-Reference" accesskey="u" rel="up">Function Reference</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h3 class="section" id="Exporting-Data-1">3.3 Exporting Data</h3>
<a class="index-entry-id" id="index-Exporting-Data"></a>
<ul class="mini-toc">
<li><a href="#sqlwrite" accesskey="1">sqlwrite</a></li>
</ul>
<div class="subsection-level-extent" id="sqlwrite">
<h4 class="subsection">3.3.1 sqlwrite</h4>
<a class="index-entry-id" id="index-sqlwrite"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqlwrite-1"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>)</code><a class="copiable-link" href='#index-sqlwrite-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlwrite-2"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">columntypes</var>)</code><a class="copiable-link" href='#index-sqlwrite-2'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlwrite-3"><span class="category-def">: </span><span><strong class="def-name">sqlwrite</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-sqlwrite-3'></a></span></dt>
<dd><p>Insert rows of data into a table.
</p>
<p>Insert rows of data into a database table.
 If the table does not exist it will be created, using the ColumnType property if available
 otherwise, the type of input data will be used to determine field types.
</p>
<h4 class="subsubheading" id="Inputs-10">Inputs</h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database connection object
</p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of table to write data to
</p></dd>
<dt><var class="var">data</var></dt>
<dd><p>Table containing data to write to the database. Variables names are expected to match the database.
</p></dd>
<dt><var class="var">columntypes</var></dt>
<dd><p>Optional cell array of same size as data used if table must be created. The column types may also
 be passed in using the <var class="var">propertyname</var>, <var class="var">propertyvalue</var> syntax.
</p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>ColumnType</dt>
<dd><p>Optional cell array of same size as the data that may be used
  if the table is created as part of the write operation.
  </p></dd>
</dl>
</dd>
</dl>
<h4 class="subsubheading" id="Outputs-10">Outputs</h4>
<p>None
</p>
<p><strong class="strong">See also:</strong> database, odbc, sqlread.
</p></dd></dl>
<hr>
</div>
</div>
<div class="section-level-extent" id="Database-Operations">
<div class="nav-panel">
<p>
Next: <a href="#Support-Functions" accesskey="n" rel="next">Support Functions</a>, Previous: <a href="#Exporting-Data" accesskey="p" rel="prev">Exporting Data</a>, Up: <a href="#Function-Reference" accesskey="u" rel="up">Function Reference</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h3 class="section" id="Database-Operations-1">3.4 Database Operations</h3>
<a class="index-entry-id" id="index-Database-Operations"></a>
<ul class="mini-toc">
<li><a href="#commit" accesskey="1">commit</a></li>
<li><a href="#execute" accesskey="2">execute</a></li>
<li><a href="#rollback" accesskey="3">rollback</a></li>
<li><a href="#sqlupdate" accesskey="4">sqlupdate</a></li>
<li><a href="#update" accesskey="5">update</a></li>
</ul>
<div class="subsection-level-extent" id="commit">
<h4 class="subsection">3.4.1 commit</h4>
<a class="index-entry-id" id="index-commit"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-commit-1"><span class="category-def">: </span><span><strong class="def-name">commit</strong> <code class="def-code-arguments">(<var class="var">conn</var>)</code><a class="copiable-link" href='#index-commit-1'></a></span></dt>
<dd><p>Make permanant changes to the database.
</p>
<h4 class="subsubheading" id="Inputs-11">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database.
</p></dd>
</dl>
<h4 class="subsubheading" id="Outputs-11">Outputs</h4>
<p>None
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="execute">
<h4 class="subsection">3.4.2 execute</h4>
<a class="index-entry-id" id="index-execute"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-execute-1"><span class="category-def">: </span><span><strong class="def-name">execute</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">query</var>)</code><a class="copiable-link" href='#index-execute-1'></a></span></dt>
<dd><p>Perform SQL query <var class="var">query</var>, that does not return result
</p>
<h4 class="subsubheading" id="Inputs-12">Inputs</h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database cnnection object
</p></dd>
<dt><var class="var">sqlquery</var></dt>
<dd><p>A valid non selecting SQL query string
</p></dd>
</dl>
<h4 class="subsubheading" id="Outputs-12">Outputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples-5">Examples</h4>
<p>Create a database table and insert a row
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # create table and then insert a row
 execute(db, 'CREATE TABLE Test (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT)');
 execute(db, 'INSERT INTO Test (Name) VALUES (&quot;Line1&quot;)');
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> database, fetch.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="rollback">
<h4 class="subsection">3.4.3 rollback</h4>
<a class="index-entry-id" id="index-rollback"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-rollback-1"><span class="category-def">: </span><span><strong class="def-name">rollback</strong> <code class="def-code-arguments">(<var class="var">conn</var>)</code><a class="copiable-link" href='#index-rollback-1'></a></span></dt>
<dd><p>Rollback changes to the database.
</p>
<h4 class="subsubheading" id="Inputs-13">Inputs</h4>
<dl class="table">
<dt><var class="var">conn</var></dt>
<dd><p>currently open database.
</p></dd>
</dl>
<h4 class="subsubheading" id="Outputs-13">Outputs</h4>
<p>None
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="sqlupdate">
<h4 class="subsection">3.4.4 sqlupdate</h4>
<a class="index-entry-id" id="index-sqlupdate"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-sqlupdate-1"><span class="category-def">: </span><span><strong class="def-name">sqlupdate</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">filter</var>)</code><a class="copiable-link" href='#index-sqlupdate-1'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-sqlupdate-2"><span class="category-def">: </span><span><strong class="def-name">sqlupdate</strong> <code class="def-code-arguments">(<var class="var">db</var>, <var class="var">tablename</var>, <var class="var">data</var>, <var class="var">filter</var>, <var class="var">propertyname</var>, <var class="var">propertyvalue</var> &hellip;)</code><a class="copiable-link" href='#index-sqlupdate-2'></a></span></dt>
<dd><p>Update rows of data in database.
</p>
<h4 class="subsubheading" id="Inputs-14">Inputs</h4>
<dl class="table">
<dt><var class="var">db</var></dt>
<dd><p>Previously created database connection object
</p></dd>
<dt><var class="var">tablename</var></dt>
<dd><p>Name of table to write data to
</p></dd>
<dt><var class="var">data</var></dt>
<dd><p>Table containing or struct data to write to the database. Variables names are expected to match the database.
</p></dd>
<dt><var class="var">filter</var></dt>
<dd><p>A Filter object  or cell array of filter objects used to determine which rows of the table to update.
</p></dd>
<dt><var class="var">propertyname</var>, <var class="var">propertyvalue</var></dt>
<dd><p>property name/value pairs where known properties are:
  </p><dl class="table">
<dt>Catalog</dt>
<dd><p>An optional database catalog name.
  </p></dd>
<dt>Schema</dt>
<dd><p>An optional database schema name.
  </p></dd>
</dl>
</dd>
</dl>
<h4 class="subsubheading" id="Outputs-14">Outputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples-6">Examples</h4>
<p>Update db where id &gt; 1
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # make a filter to select what to update
 rf = rowfilter({'Id'});
 rf = rf.Id &gt; 1;
 # update name where Id &gt; 1
 t = table(['Name3'], 'VariableNames', {'Name'});
 sqlupdate(db, &quot;Test&quot;, t, rf);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> update.
</p></dd></dl>
</div>
<div class="subsection-level-extent" id="update">
<h4 class="subsection">3.4.5 update</h4>
<a class="index-entry-id" id="index-update"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-update-1"><span class="category-def">: </span><span><strong class="def-name">update</strong> <code class="def-code-arguments">(<var class="var">conn</var>, <var class="var">tablename</var>, <var class="var">colnames</var>, <var class="var">data</var>, <var class="var">whereclause</var>)</code><a class="copiable-link" href='#index-update-1'></a></span></dt>
<dd><p>Update columns in database.
</p>
<h4 class="subsubheading" id="Inputs-15">Inputs</h4>
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
<h4 class="subsubheading" id="Outputs-15">Outputs</h4>
<p>None
</p>
<h4 class="subsubheading" id="Examples-7">Examples</h4>
<p>Update a row in the database
</p><div class="example">
<pre class="example-preformatted"><code class="code">
 # create sql connection
 db = database(&quot;default&quot;, &quot;&quot;, &quot;&quot;);
 # update name where Id &gt; 1
 t = table(['Name3'], 'VariableNames', {'Name'});
 update(db, &quot;Test&quot;, t, &quot;WHERE Id &gt; 1&quot;);
 </code>
</pre></div>
<p><strong class="strong">See also:</strong> sqlupdate.
</p></dd></dl>
<hr>
</div>
</div>
<div class="section-level-extent" id="Support-Functions">
<div class="nav-panel">
<p>
Previous: <a href="#Database-Operations" accesskey="p" rel="prev">Database Operations</a>, Up: <a href="#Function-Reference" accesskey="u" rel="up">Function Reference</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h3 class="section" id="Support-Functions-1">3.5 Support Functions</h3>
<a class="index-entry-id" id="index-Support-Functions"></a>
<ul class="mini-toc">
<li><a href="#rowfilter" accesskey="1">rowfilter</a></li>
</ul>
<div class="subsection-level-extent" id="rowfilter">
<h4 class="subsection">3.5.1 rowfilter</h4>
<a class="index-entry-id" id="index-rowfilter"></a>
<dl class="first-deftypefn">
<dt class="deftypefn" id="index-rowfilter_0028C_0029"><span class="category-def">: </span><span><code class="def-type"><var class="var">rowfilt</var> =</code> <strong class="def-name">rowfilter(<var class="var">C</var>)</strong><a class="copiable-link" href='#index-rowfilter_0028C_0029'></a></span></dt>
<dt class="deftypefnx def-cmd-deftypefn" id="index-rowfilter_0028T_0029"><span class="category-def">: </span><span><code class="def-type"><var class="var">rowfilt</var> =</code> <strong class="def-name">rowfilter(<var class="var">T</var>)</strong><a class="copiable-link" href='#index-rowfilter_0028T_0029'></a></span></dt>
<dd><p>Create an unconstrained rowfilter object with columns names.
</p>
<h4 class="subsubheading" id="Inputs-16">Inputs</h4>
<dl class="table">
<dt><var class="var">C</var></dt>
<dd><p>A column name, cell array of column names.
</p></dd>
<dt><var class="var">T</var></dt>
<dd><p>A table to use for column names.
</p></dd>
</dl>
<h4 class="subsubheading" id="Outputs-16">Outputs</h4>
<dl class="table">
<dt><var class="var">rowfilt</var></dt>
<dd><p>a rowfilter object
</p></dd>
</dl>
<h4 class="subsubheading" id="Object-Properties-1">Object Properties</h4>
<p>Object properties are the names of the columns on creation of the filter.
</p>
<p>Constraints can be set on a specific field of the filter by setting a
 comparison value for the variable name.
</p>
<h4 class="subsubheading" id="Examples-8">Examples</h4>
<div class="example">
<pre class="example-preformatted"><code class="code">
 # create a rowfilter with 2 columns
 rf = rowfilter({'Column1', 'Column2'});
 # add a constraint for Column1 &gt; 10
 rfc = rf.Column1 &gt; 10
 </code>
</pre></div>
</dd></dl>
<hr>
</div>
</div>
</div>
<div class="appendix-level-extent" id="Copying">
<div class="nav-panel">
<p>
Next: <a href="#Index" accesskey="n" rel="next">Index</a>, Previous: <a href="#Function-Reference" accesskey="p" rel="prev">Function Reference</a>, Up: <a href="#Top" accesskey="u" rel="up">Introduction</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h2 class="appendix" id="GNU-General-Public-License">Appendix A GNU General Public License</h2>
<a class="index-entry-id" id="index-warranty"></a>
<a class="index-entry-id" id="index-copyright"></a>
<div class="center">Version 3, 29 June 2007
</div>
<div class="display">
<pre class="display-preformatted">Copyright &copy; 2007 Free Software Foundation, Inc. <a class="url" href="http://fsf.org/">http://fsf.org/</a>
Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.
</pre></div>
<h3 class="heading" id="Preamble">Preamble</h3>
<p>The GNU General Public License is a free, copyleft license for
software and other kinds of works.
</p>
<p>The licenses for most software and other practical works are designed
to take away your freedom to share and change the works.  By contrast,
the GNU General Public License is intended to guarantee your freedom
to share and change all versions of a program&mdash;to make sure it remains
free software for all its users.  We, the Free Software Foundation,
use the GNU General Public License for most of our software; it
applies also to any other work released this way by its authors.  You
can apply it to your programs, too.
</p>
<p>When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
them if you wish), that you receive source code or can get it if you
want it, that you can change the software or use pieces of it in new
free programs, and that you know you can do these things.
</p>
<p>To protect your rights, we need to prevent others from denying you
these rights or asking you to surrender the rights.  Therefore, you
have certain responsibilities if you distribute copies of the
software, or if you modify it: responsibilities to respect the freedom
of others.
</p>
<p>For example, if you distribute copies of such a program, whether
gratis or for a fee, you must pass on to the recipients the same
freedoms that you received.  You must make sure that they, too,
receive or can get the source code.  And you must show them these
terms so they know their rights.
</p>
<p>Developers that use the GNU GPL protect your rights with two steps:
(1) assert copyright on the software, and (2) offer you this License
giving you legal permission to copy, distribute and/or modify it.
</p>
<p>For the developers&rsquo; and authors&rsquo; protection, the GPL clearly explains
that there is no warranty for this free software.  For both users&rsquo; and
authors&rsquo; sake, the GPL requires that modified versions be marked as
changed, so that their problems will not be attributed erroneously to
authors of previous versions.
</p>
<p>Some devices are designed to deny users access to install or run
modified versions of the software inside them, although the
manufacturer can do so.  This is fundamentally incompatible with the
aim of protecting users&rsquo; freedom to change the software.  The
systematic pattern of such abuse occurs in the area of products for
individuals to use, which is precisely where it is most unacceptable.
Therefore, we have designed this version of the GPL to prohibit the
practice for those products.  If such problems arise substantially in
other domains, we stand ready to extend this provision to those
domains in future versions of the GPL, as needed to protect the
freedom of users.
</p>
<p>Finally, every program is threatened constantly by software patents.
States should not allow patents to restrict development and use of
software on general-purpose computers, but in those that do, we wish
to avoid the special danger that patents applied to a free program
could make it effectively proprietary.  To prevent this, the GPL
assures that patents cannot be used to render the program non-free.
</p>
<p>The precise terms and conditions for copying, distribution and
modification follow.
</p>
<h3 class="heading" id="TERMS-AND-CONDITIONS">TERMS AND CONDITIONS</h3>
<ol class="enumerate" start="0">
<li> Definitions.
<p>&ldquo;This License&rdquo; refers to version 3 of the GNU General Public License.
</p>
<p>&ldquo;Copyright&rdquo; also means copyright-like laws that apply to other kinds
of works, such as semiconductor masks.
</p>
<p>&ldquo;The Program&rdquo; refers to any copyrightable work licensed under this
License.  Each licensee is addressed as &ldquo;you&rdquo;.  &ldquo;Licensees&rdquo; and
&ldquo;recipients&rdquo; may be individuals or organizations.
</p>
<p>To &ldquo;modify&rdquo; a work means to copy from or adapt all or part of the work
in a fashion requiring copyright permission, other than the making of
an exact copy.  The resulting work is called a &ldquo;modified version&rdquo; of
the earlier work or a work &ldquo;based on&rdquo; the earlier work.
</p>
<p>A &ldquo;covered work&rdquo; means either the unmodified Program or a work based
on the Program.
</p>
<p>To &ldquo;propagate&rdquo; a work means to do anything with it that, without
permission, would make you directly or secondarily liable for
infringement under applicable copyright law, except executing it on a
computer or modifying a private copy.  Propagation includes copying,
distribution (with or without modification), making available to the
public, and in some countries other activities as well.
</p>
<p>To &ldquo;convey&rdquo; a work means any kind of propagation that enables other
parties to make or receive copies.  Mere interaction with a user
through a computer network, with no transfer of a copy, is not
conveying.
</p>
<p>An interactive user interface displays &ldquo;Appropriate Legal Notices&rdquo; to
the extent that it includes a convenient and prominently visible
feature that (1) displays an appropriate copyright notice, and (2)
tells the user that there is no warranty for the work (except to the
extent that warranties are provided), that licensees may convey the
work under this License, and how to view a copy of this License.  If
the interface presents a list of user commands or options, such as a
menu, a prominent item in the list meets this criterion.
</p>
</li><li> Source Code.
<p>The &ldquo;source code&rdquo; for a work means the preferred form of the work for
making modifications to it.  &ldquo;Object code&rdquo; means any non-source form
of a work.
</p>
<p>A &ldquo;Standard Interface&rdquo; means an interface that either is an official
standard defined by a recognized standards body, or, in the case of
interfaces specified for a particular programming language, one that
is widely used among developers working in that language.
</p>
<p>The &ldquo;System Libraries&rdquo; of an executable work include anything, other
than the work as a whole, that (a) is included in the normal form of
packaging a Major Component, but which is not part of that Major
Component, and (b) serves only to enable use of the work with that
Major Component, or to implement a Standard Interface for which an
implementation is available to the public in source code form.  A
&ldquo;Major Component&rdquo;, in this context, means a major essential component
(kernel, window system, and so on) of the specific operating system
(if any) on which the executable work runs, or a compiler used to
produce the work, or an object code interpreter used to run it.
</p>
<p>The &ldquo;Corresponding Source&rdquo; for a work in object code form means all
the source code needed to generate, install, and (for an executable
work) run the object code and to modify the work, including scripts to
control those activities.  However, it does not include the work&rsquo;s
System Libraries, or general-purpose tools or generally available free
programs which are used unmodified in performing those activities but
which are not part of the work.  For example, Corresponding Source
includes interface definition files associated with source files for
the work, and the source code for shared libraries and dynamically
linked subprograms that the work is specifically designed to require,
such as by intimate data communication or control flow between those
subprograms and other parts of the work.
</p>
<p>The Corresponding Source need not include anything that users can
regenerate automatically from other parts of the Corresponding Source.
</p>
<p>The Corresponding Source for a work in source code form is that same
work.
</p>
</li><li> Basic Permissions.
<p>All rights granted under this License are granted for the term of
copyright on the Program, and are irrevocable provided the stated
conditions are met.  This License explicitly affirms your unlimited
permission to run the unmodified Program.  The output from running a
covered work is covered by this License only if the output, given its
content, constitutes a covered work.  This License acknowledges your
rights of fair use or other equivalent, as provided by copyright law.
</p>
<p>You may make, run and propagate covered works that you do not convey,
without conditions so long as your license otherwise remains in force.
You may convey covered works to others for the sole purpose of having
them make modifications exclusively for you, or provide you with
facilities for running those works, provided that you comply with the
terms of this License in conveying all material for which you do not
control copyright.  Those thus making or running the covered works for
you must do so exclusively on your behalf, under your direction and
control, on terms that prohibit them from making any copies of your
copyrighted material outside their relationship with you.
</p>
<p>Conveying under any other circumstances is permitted solely under the
conditions stated below.  Sublicensing is not allowed; section 10
makes it unnecessary.
</p>
</li><li> Protecting Users&rsquo; Legal Rights From Anti-Circumvention Law.
<p>No covered work shall be deemed part of an effective technological
measure under any applicable law fulfilling obligations under article
11 of the WIPO copyright treaty adopted on 20 December 1996, or
similar laws prohibiting or restricting circumvention of such
measures.
</p>
<p>When you convey a covered work, you waive any legal power to forbid
circumvention of technological measures to the extent such
circumvention is effected by exercising rights under this License with
respect to the covered work, and you disclaim any intention to limit
operation or modification of the work as a means of enforcing, against
the work&rsquo;s users, your or third parties&rsquo; legal rights to forbid
circumvention of technological measures.
</p>
</li><li> Conveying Verbatim Copies.
<p>You may convey verbatim copies of the Program&rsquo;s source code as you
receive it, in any medium, provided that you conspicuously and
appropriately publish on each copy an appropriate copyright notice;
keep intact all notices stating that this License and any
non-permissive terms added in accord with section 7 apply to the code;
keep intact all notices of the absence of any warranty; and give all
recipients a copy of this License along with the Program.
</p>
<p>You may charge any price or no price for each copy that you convey,
and you may offer support or warranty protection for a fee.
</p>
</li><li> Conveying Modified Source Versions.
<p>You may convey a work based on the Program, or the modifications to
produce it from the Program, in the form of source code under the
terms of section 4, provided that you also meet all of these
conditions:
</p>
<ol class="enumerate" type="a" start="1">
<li> The work must carry prominent notices stating that you modified it,
and giving a relevant date.
</li><li> The work must carry prominent notices stating that it is released
under this License and any conditions added under section 7.  This
requirement modifies the requirement in section 4 to &ldquo;keep intact all
notices&rdquo;.
</li><li> You must license the entire work, as a whole, under this License to
anyone who comes into possession of a copy.  This License will
therefore apply, along with any applicable section 7 additional terms,
to the whole of the work, and all its parts, regardless of how they
are packaged.  This License gives no permission to license the work in
any other way, but it does not invalidate such permission if you have
separately received it.
</li><li> If the work has interactive user interfaces, each must display
Appropriate Legal Notices; however, if the Program has interactive
interfaces that do not display Appropriate Legal Notices, your work
need not make them do so.
</li></ol>
<p>A compilation of a covered work with other separate and independent
works, which are not by their nature extensions of the covered work,
and which are not combined with it such as to form a larger program,
in or on a volume of a storage or distribution medium, is called an
&ldquo;aggregate&rdquo; if the compilation and its resulting copyright are not
used to limit the access or legal rights of the compilation&rsquo;s users
beyond what the individual works permit.  Inclusion of a covered work
in an aggregate does not cause this License to apply to the other
parts of the aggregate.
</p>
</li><li> Conveying Non-Source Forms.
<p>You may convey a covered work in object code form under the terms of
sections 4 and 5, provided that you also convey the machine-readable
Corresponding Source under the terms of this License, in one of these
ways:
</p>
<ol class="enumerate" type="a" start="1">
<li> Convey the object code in, or embodied in, a physical product
(including a physical distribution medium), accompanied by the
Corresponding Source fixed on a durable physical medium customarily
used for software interchange.
</li><li> Convey the object code in, or embodied in, a physical product
(including a physical distribution medium), accompanied by a written
offer, valid for at least three years and valid for as long as you
offer spare parts or customer support for that product model, to give
anyone who possesses the object code either (1) a copy of the
Corresponding Source for all the software in the product that is
covered by this License, on a durable physical medium customarily used
for software interchange, for a price no more than your reasonable
cost of physically performing this conveying of source, or (2) access
to copy the Corresponding Source from a network server at no charge.
</li><li> Convey individual copies of the object code with a copy of the written
offer to provide the Corresponding Source.  This alternative is
allowed only occasionally and noncommercially, and only if you
received the object code with such an offer, in accord with subsection
6b.
</li><li> Convey the object code by offering access from a designated place
(gratis or for a charge), and offer equivalent access to the
Corresponding Source in the same way through the same place at no
further charge.  You need not require recipients to copy the
Corresponding Source along with the object code.  If the place to copy
the object code is a network server, the Corresponding Source may be
on a different server (operated by you or a third party) that supports
equivalent copying facilities, provided you maintain clear directions
next to the object code saying where to find the Corresponding Source.
Regardless of what server hosts the Corresponding Source, you remain
obligated to ensure that it is available for as long as needed to
satisfy these requirements.
</li><li> Convey the object code using peer-to-peer transmission, provided you
inform other peers where the object code and Corresponding Source of
the work are being offered to the general public at no charge under
subsection 6d.
</li></ol>
<p>A separable portion of the object code, whose source code is excluded
from the Corresponding Source as a System Library, need not be
included in conveying the object code work.
</p>
<p>A &ldquo;User Product&rdquo; is either (1) a &ldquo;consumer product&rdquo;, which means any
tangible personal property which is normally used for personal,
family, or household purposes, or (2) anything designed or sold for
incorporation into a dwelling.  In determining whether a product is a
consumer product, doubtful cases shall be resolved in favor of
coverage.  For a particular product received by a particular user,
&ldquo;normally used&rdquo; refers to a typical or common use of that class of
product, regardless of the status of the particular user or of the way
in which the particular user actually uses, or expects or is expected
to use, the product.  A product is a consumer product regardless of
whether the product has substantial commercial, industrial or
non-consumer uses, unless such uses represent the only significant
mode of use of the product.
</p>
<p>&ldquo;Installation Information&rdquo; for a User Product means any methods,
procedures, authorization keys, or other information required to
install and execute modified versions of a covered work in that User
Product from a modified version of its Corresponding Source.  The
information must suffice to ensure that the continued functioning of
the modified object code is in no case prevented or interfered with
solely because modification has been made.
</p>
<p>If you convey an object code work under this section in, or with, or
specifically for use in, a User Product, and the conveying occurs as
part of a transaction in which the right of possession and use of the
User Product is transferred to the recipient in perpetuity or for a
fixed term (regardless of how the transaction is characterized), the
Corresponding Source conveyed under this section must be accompanied
by the Installation Information.  But this requirement does not apply
if neither you nor any third party retains the ability to install
modified object code on the User Product (for example, the work has
been installed in ROM).
</p>
<p>The requirement to provide Installation Information does not include a
requirement to continue to provide support service, warranty, or
updates for a work that has been modified or installed by the
recipient, or for the User Product in which it has been modified or
installed.  Access to a network may be denied when the modification
itself materially and adversely affects the operation of the network
or violates the rules and protocols for communication across the
network.
</p>
<p>Corresponding Source conveyed, and Installation Information provided,
in accord with this section must be in a format that is publicly
documented (and with an implementation available to the public in
source code form), and must require no special password or key for
unpacking, reading or copying.
</p>
</li><li> Additional Terms.
<p>&ldquo;Additional permissions&rdquo; are terms that supplement the terms of this
License by making exceptions from one or more of its conditions.
Additional permissions that are applicable to the entire Program shall
be treated as though they were included in this License, to the extent
that they are valid under applicable law.  If additional permissions
apply only to part of the Program, that part may be used separately
under those permissions, but the entire Program remains governed by
this License without regard to the additional permissions.
</p>
<p>When you convey a copy of a covered work, you may at your option
remove any additional permissions from that copy, or from any part of
it.  (Additional permissions may be written to require their own
removal in certain cases when you modify the work.)  You may place
additional permissions on material, added by you to a covered work,
for which you have or can give appropriate copyright permission.
</p>
<p>Notwithstanding any other provision of this License, for material you
add to a covered work, you may (if authorized by the copyright holders
of that material) supplement the terms of this License with terms:
</p>
<ol class="enumerate" type="a" start="1">
<li> Disclaiming warranty or limiting liability differently from the terms
of sections 15 and 16 of this License; or
</li><li> Requiring preservation of specified reasonable legal notices or author
attributions in that material or in the Appropriate Legal Notices
displayed by works containing it; or
</li><li> Prohibiting misrepresentation of the origin of that material, or
requiring that modified versions of such material be marked in
reasonable ways as different from the original version; or
</li><li> Limiting the use for publicity purposes of names of licensors or
authors of the material; or
</li><li> Declining to grant rights under trademark law for use of some trade
names, trademarks, or service marks; or
</li><li> Requiring indemnification of licensors and authors of that material by
anyone who conveys the material (or modified versions of it) with
contractual assumptions of liability to the recipient, for any
liability that these contractual assumptions directly impose on those
licensors and authors.
</li></ol>
<p>All other non-permissive additional terms are considered &ldquo;further
restrictions&rdquo; within the meaning of section 10.  If the Program as you
received it, or any part of it, contains a notice stating that it is
governed by this License along with a term that is a further
restriction, you may remove that term.  If a license document contains
a further restriction but permits relicensing or conveying under this
License, you may add to a covered work material governed by the terms
of that license document, provided that the further restriction does
not survive such relicensing or conveying.
</p>
<p>If you add terms to a covered work in accord with this section, you
must place, in the relevant source files, a statement of the
additional terms that apply to those files, or a notice indicating
where to find the applicable terms.
</p>
<p>Additional terms, permissive or non-permissive, may be stated in the
form of a separately written license, or stated as exceptions; the
above requirements apply either way.
</p>
</li><li> Termination.
<p>You may not propagate or modify a covered work except as expressly
provided under this License.  Any attempt otherwise to propagate or
modify it is void, and will automatically terminate your rights under
this License (including any patent licenses granted under the third
paragraph of section 11).
</p>
<p>However, if you cease all violation of this License, then your license
from a particular copyright holder is reinstated (a) provisionally,
unless and until the copyright holder explicitly and finally
terminates your license, and (b) permanently, if the copyright holder
fails to notify you of the violation by some reasonable means prior to
60 days after the cessation.
</p>
<p>Moreover, your license from a particular copyright holder is
reinstated permanently if the copyright holder notifies you of the
violation by some reasonable means, this is the first time you have
received notice of violation of this License (for any work) from that
copyright holder, and you cure the violation prior to 30 days after
your receipt of the notice.
</p>
<p>Termination of your rights under this section does not terminate the
licenses of parties who have received copies or rights from you under
this License.  If your rights have been terminated and not permanently
reinstated, you do not qualify to receive new licenses for the same
material under section 10.
</p>
</li><li> Acceptance Not Required for Having Copies.
<p>You are not required to accept this License in order to receive or run
a copy of the Program.  Ancillary propagation of a covered work
occurring solely as a consequence of using peer-to-peer transmission
to receive a copy likewise does not require acceptance.  However,
nothing other than this License grants you permission to propagate or
modify any covered work.  These actions infringe copyright if you do
not accept this License.  Therefore, by modifying or propagating a
covered work, you indicate your acceptance of this License to do so.
</p>
</li><li> Automatic Licensing of Downstream Recipients.
<p>Each time you convey a covered work, the recipient automatically
receives a license from the original licensors, to run, modify and
propagate that work, subject to this License.  You are not responsible
for enforcing compliance by third parties with this License.
</p>
<p>An &ldquo;entity transaction&rdquo; is a transaction transferring control of an
organization, or substantially all assets of one, or subdividing an
organization, or merging organizations.  If propagation of a covered
work results from an entity transaction, each party to that
transaction who receives a copy of the work also receives whatever
licenses to the work the party&rsquo;s predecessor in interest had or could
give under the previous paragraph, plus a right to possession of the
Corresponding Source of the work from the predecessor in interest, if
the predecessor has it or can get it with reasonable efforts.
</p>
<p>You may not impose any further restrictions on the exercise of the
rights granted or affirmed under this License.  For example, you may
not impose a license fee, royalty, or other charge for exercise of
rights granted under this License, and you may not initiate litigation
(including a cross-claim or counterclaim in a lawsuit) alleging that
any patent claim is infringed by making, using, selling, offering for
sale, or importing the Program or any portion of it.
</p>
</li><li> Patents.
<p>A &ldquo;contributor&rdquo; is a copyright holder who authorizes use under this
License of the Program or a work on which the Program is based.  The
work thus licensed is called the contributor&rsquo;s &ldquo;contributor version&rdquo;.
</p>
<p>A contributor&rsquo;s &ldquo;essential patent claims&rdquo; are all patent claims owned
or controlled by the contributor, whether already acquired or
hereafter acquired, that would be infringed by some manner, permitted
by this License, of making, using, or selling its contributor version,
but do not include claims that would be infringed only as a
consequence of further modification of the contributor version.  For
purposes of this definition, &ldquo;control&rdquo; includes the right to grant
patent sublicenses in a manner consistent with the requirements of
this License.
</p>
<p>Each contributor grants you a non-exclusive, worldwide, royalty-free
patent license under the contributor&rsquo;s essential patent claims, to
make, use, sell, offer for sale, import and otherwise run, modify and
propagate the contents of its contributor version.
</p>
<p>In the following three paragraphs, a &ldquo;patent license&rdquo; is any express
agreement or commitment, however denominated, not to enforce a patent
(such as an express permission to practice a patent or covenant not to
sue for patent infringement).  To &ldquo;grant&rdquo; such a patent license to a
party means to make such an agreement or commitment not to enforce a
patent against the party.
</p>
<p>If you convey a covered work, knowingly relying on a patent license,
and the Corresponding Source of the work is not available for anyone
to copy, free of charge and under the terms of this License, through a
publicly available network server or other readily accessible means,
then you must either (1) cause the Corresponding Source to be so
available, or (2) arrange to deprive yourself of the benefit of the
patent license for this particular work, or (3) arrange, in a manner
consistent with the requirements of this License, to extend the patent
license to downstream recipients.  &ldquo;Knowingly relying&rdquo; means you have
actual knowledge that, but for the patent license, your conveying the
covered work in a country, or your recipient&rsquo;s use of the covered work
in a country, would infringe one or more identifiable patents in that
country that you have reason to believe are valid.
</p>
<p>If, pursuant to or in connection with a single transaction or
arrangement, you convey, or propagate by procuring conveyance of, a
covered work, and grant a patent license to some of the parties
receiving the covered work authorizing them to use, propagate, modify
or convey a specific copy of the covered work, then the patent license
you grant is automatically extended to all recipients of the covered
work and works based on it.
</p>
<p>A patent license is &ldquo;discriminatory&rdquo; if it does not include within the
scope of its coverage, prohibits the exercise of, or is conditioned on
the non-exercise of one or more of the rights that are specifically
granted under this License.  You may not convey a covered work if you
are a party to an arrangement with a third party that is in the
business of distributing software, under which you make payment to the
third party based on the extent of your activity of conveying the
work, and under which the third party grants, to any of the parties
who would receive the covered work from you, a discriminatory patent
license (a) in connection with copies of the covered work conveyed by
you (or copies made from those copies), or (b) primarily for and in
connection with specific products or compilations that contain the
covered work, unless you entered into that arrangement, or that patent
license was granted, prior to 28 March 2007.
</p>
<p>Nothing in this License shall be construed as excluding or limiting
any implied license or other defenses to infringement that may
otherwise be available to you under applicable patent law.
</p>
</li><li> No Surrender of Others&rsquo; Freedom.
<p>If conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot convey
a covered work so as to satisfy simultaneously your obligations under
this License and any other pertinent obligations, then as a
consequence you may not convey it at all.  For example, if you agree
to terms that obligate you to collect a royalty for further conveying
from those to whom you convey the Program, the only way you could
satisfy both those terms and this License would be to refrain entirely
from conveying the Program.
</p>
</li><li> Use with the GNU Affero General Public License.
<p>Notwithstanding any other provision of this License, you have
permission to link or combine any covered work with a work licensed
under version 3 of the GNU Affero General Public License into a single
combined work, and to convey the resulting work.  The terms of this
License will continue to apply to the part which is the covered work,
but the special requirements of the GNU Affero General Public License,
section 13, concerning interaction through a network will apply to the
combination as such.
</p>
</li><li> Revised Versions of this License.
<p>The Free Software Foundation may publish revised and/or new versions
of the GNU General Public License from time to time.  Such new
versions will be similar in spirit to the present version, but may
differ in detail to address new problems or concerns.
</p>
<p>Each version is given a distinguishing version number.  If the Program
specifies that a certain numbered version of the GNU General Public
License &ldquo;or any later version&rdquo; applies to it, you have the option of
following the terms and conditions either of that numbered version or
of any later version published by the Free Software Foundation.  If
the Program does not specify a version number of the GNU General
Public License, you may choose any version ever published by the Free
Software Foundation.
</p>
<p>If the Program specifies that a proxy can decide which future versions
of the GNU General Public License can be used, that proxy&rsquo;s public
statement of acceptance of a version permanently authorizes you to
choose that version for the Program.
</p>
<p>Later license versions may give you additional or different
permissions.  However, no additional obligations are imposed on any
author or copyright holder as a result of your choosing to follow a
later version.
</p>
</li><li> Disclaimer of Warranty.
<p>THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM &ldquo;AS IS&rdquo; WITHOUT
WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND
PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE PROGRAM PROVE
DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR
CORRECTION.
</p>
</li><li> Limitation of Liability.
<p>IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR
CONVEYS THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES
ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT
NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR
LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM
TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER
PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
</p>
</li><li> Interpretation of Sections 15 and 16.
<p>If the disclaimer of warranty and limitation of liability provided
above cannot be given local legal effect according to their terms,
reviewing courts shall apply local law that most closely approximates
an absolute waiver of all civil liability in connection with the
Program, unless a warranty or assumption of liability accompanies a
copy of the Program in return for a fee.
</p>
</li></ol>
<h3 class="heading" id="END-OF-TERMS-AND-CONDITIONS">END OF TERMS AND CONDITIONS</h3>
<h3 class="heading" id="How-to-Apply-These-Terms-to-Your-New-Programs">How to Apply These Terms to Your New Programs</h3>
<p>If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these
terms.
</p>
<p>To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
state the exclusion of warranty; and each file should have at least
the &ldquo;copyright&rdquo; line and a pointer to where the full notice is found.
</p>
<div class="example smallexample">
<pre class="example-preformatted"><var class="var">one line to give the program's name and a brief idea of what it does.</var>  
Copyright (C) <var class="var">year</var> <var class="var">name of author</var>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.
This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <a class="url" href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
</pre></div>
<p>Also add information on how to contact you by electronic and paper mail.
</p>
<p>If the program does terminal interaction, make it output a short
notice like this when it starts in an interactive mode:
</p>
<div class="example smallexample">
<pre class="example-preformatted"><var class="var">program</var> Copyright (C) <var class="var">year</var> <var class="var">name of author</var> 
This program comes with ABSOLUTELY NO WARRANTY; for details type &lsquo;<samp class="samp">show w</samp>&rsquo;.
This is free software, and you are welcome to redistribute it
under certain conditions; type &lsquo;<samp class="samp">show c</samp>&rsquo; for details.
</pre></div>
<p>The hypothetical commands &lsquo;<samp class="samp">show w</samp>&rsquo; and &lsquo;<samp class="samp">show c</samp>&rsquo; should show
the appropriate parts of the General Public License.  Of course, your
program&rsquo;s commands might be different; for a GUI interface, you would
use an &ldquo;about box&rdquo;.
</p>
<p>You should also get your employer (if you work as a programmer) or school,
if any, to sign a &ldquo;copyright disclaimer&rdquo; for the program, if necessary.
For more information on this, and how to apply and follow the GNU GPL, see
<a class="url" href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
</p>
<p>The GNU General Public License does not permit incorporating your
program into proprietary programs.  If your program is a subroutine
library, you may consider it more useful to permit linking proprietary
applications with the library.  If this is what you want to do, use
the GNU Lesser General Public License instead of this License.  But
first, please read <a class="url" href="http://www.gnu.org/philosophy/why-not-lgpl.html">http://www.gnu.org/philosophy/why-not-lgpl.html</a>.
</p>
<hr>
</div>
<div class="unnumbered-level-extent" id="Index">
<div class="nav-panel">
<p>
Previous: <a href="#Copying" accesskey="p" rel="prev">GNU General Public License</a>, Up: <a href="#Top" accesskey="u" rel="up">Introduction</a> &nbsp; [<a href="#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="#Index" title="Index" rel="index">Index</a>]</p>
</div>
<h2 class="unnumbered" id="Index-1">Index</h2>
 
<div class="printindex cp-printindex">
<table class="cp-letters-header-printindex"><tr><th>Jump to: &nbsp; </th><td><a class="summary-letter-printindex" href="#Index_cp_letter-B"><b>B</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-C"><b>C</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-D"><b>D</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-E"><b>E</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-F"><b>F</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-I"><b>I</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-L"><b>L</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-O"><b>O</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-R"><b>R</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-S"><b>S</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-U"><b>U</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-W"><b>W</b></a>
 &nbsp; 
</td></tr></table>
<table class="cp-entries-printindex" border="0">
<tr><td></td><th class="entries-header-printindex">Index Entry</th><td>&nbsp;</td><th class="sections-header-printindex"> Section</th></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-B">B</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Basic-Usage-Overview">Basic Usage Overview</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Basic-Usage-Overview">Basic Usage Overview</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-C">C</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Close-the-database">Close the database</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Basic-Usage-Overview">Basic Usage Overview</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-commit">commit</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-configureODBCDataSource">configureODBCDataSource</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-connection">connection</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-copyright">copyright</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Copying">Copying</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-D">D</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-database">database</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Database-Configuration">Database Configuration</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Basic-Usage-Overview">Basic Usage Overview</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Database-Connection">Database Connection</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Basic-Usage-Overview">Basic Usage Overview</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Database-Operations">Database Operations</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-E">E</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-execute">execute</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-executeSQLScript">executeSQLScript</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Exporting-Data">Exporting Data</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Exporting-Data">Exporting Data</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-F">F</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-fetch">fetch</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Function-Reference">Function Reference</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Function-Reference">Function Reference</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-I">I</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Importing-Data">Importing Data</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Installing-and-loading">Installing and loading</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Installing-and-loading">Installing and loading</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-L">L</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-listDataSources">listDataSources</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Loading">Loading</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Installing-and-loading">Installing and loading</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-O">O</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-odbc">odbc</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-ODBC-connection">ODBC connection</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#ODBC-connection">ODBC connection</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Off_002dline-install">Off-line install</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Installing-and-loading">Installing and loading</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Online-install">Online install</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Installing-and-loading">Installing and loading</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-R">R</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Read-a-table">Read a table</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Basic-Usage-Overview">Basic Usage Overview</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-rollback">rollback</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-rowfilter">rowfilter</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Support-Functions">Support Functions</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-S">S</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-select">select</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-sqlinnerjoin">sqlinnerjoin</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-sqlouterjoin">sqlouterjoin</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-sqlread">sqlread</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Importing-Data">Importing Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-sqlupdate">sqlupdate</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-sqlwrite">sqlwrite</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Exporting-Data">Exporting Data</a></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-Support-Functions">Support Functions</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Support-Functions">Support Functions</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-U">U</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-update">update</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Database-Operations">Database Operations</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
<tr><th id="Index_cp_letter-W">W</th><td></td><td></td></tr>
<tr><td></td><td class="printindex-index-entry"><a href="#index-warranty">warranty</a>:</td><td>&nbsp;</td><td class="printindex-index-section"><a href="#Copying">Copying</a></td></tr>
<tr><td colspan="4"> <hr></td></tr>
</table>
<table class="cp-letters-footer-printindex"><tr><th>Jump to: &nbsp; </th><td><a class="summary-letter-printindex" href="#Index_cp_letter-B"><b>B</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-C"><b>C</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-D"><b>D</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-E"><b>E</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-F"><b>F</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-I"><b>I</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-L"><b>L</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-O"><b>O</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-R"><b>R</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-S"><b>S</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-U"><b>U</b></a>
 &nbsp; 
<a class="summary-letter-printindex" href="#Index_cp_letter-W"><b>W</b></a>
 &nbsp; 
</td></tr></table>
</div>
 
</div>
</div>

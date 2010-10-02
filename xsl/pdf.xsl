<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <xsl:import href="page.xsl"/>
  <xsl:import href="link.xsl"/>
  <xsl:import href="index.xsl"/>
  <xsl:import href="flow.xsl"/>

  <xsl:include href="bibliography.xsl"/>
  <xsl:include href="callout.xsl"/>
  <xsl:include href="css.xsl"/>
  <xsl:include href="epigraph.xsl"/>
  <xsl:include href="example.xsl"/>
  <xsl:include href="glossary.xsl"/>
  <xsl:include href="list.xsl"/>
  <xsl:include href="phrasing.xsl"/>
  <xsl:include href="preamble.xsl"/>
  <xsl:include href="table.xsl"/>
  <xsl:include href="toc.xsl"/>

  <xsl:template name="normalise-id">
    <xsl:param name="id"/>
    <xsl:value-of select="$id"/>
  </xsl:template>

  <xsl:template name="id-to-href">
    <xsl:param name="id"/>
    #<xsl:value-of select="$id"/>
  </xsl:template>

  <xsl:template name="page">
    <article class="{local-name()}">
      <h1><xsl:value-of select="d:title"/></h1>
      <xsl:apply-templates/>
    </article>
  </xsl:template>

  <xsl:template name="main.css">
    <xsl:text disable-output-escaping="yes">
@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911.ttf');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911Italic.ttf');
	font-weight: normal;
	font-style: italic;
}

@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911Bold.ttf');
	font-weight: bold;
	font-style: normal;
}

body {
  font-family: 'Linux Libertine O', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif, 'unifont';
}

code,
pre {
  font-family: 'Inconsolata', 'unifont', monospace;
  font-size: 90%;
}

h1,
h1 > code {
  font-family: 'Goudy Bookletter 1911',  
               'Linux Libertine O', Palatino, 
               'Palatino Linotype', 'Book Antiqua', Georgia, 'Times New Roman', 
               serif, 'unifont';
  font-weight: normal;
}

article a:link, 
article a:visited, 
article a:hover, 
article a:active {
  text-decoration: none;
  border-bottom: 1px dotted;
  color: black;
}

sup > a:link, 
sup > a:visited, 
sup > a:hover, 
sup > a:active {
  text-decoration: none;
  border-bottom: none;
  font-weight: bold;
}

article {
  page-break-before: always;
}

/* Main article */
article > h1 {
  font-size: 500%;
  text-transform: uppercase;
  text-align: center;
  line-height: 80%;
  font-weight: bold;
  margin: 0;
}
article > section > h1 {
  font-size: 200%;
  text-align: center;
  font-weight: normal;
}

article > section > section > h1 {
  font-size: 150%;
  font-weight: normal;
}

section > section > section > h1 {
  font-size: 130%;
  font-weight: normal;
}

table {
  margin-left: auto;
  margin-right: auto;
}
table thead {
  border-top: 1px solid black;
  border-bottom: 1px solid black;
}

/* All table cells are bordered with a thin black line */
table, 
table th,  
table tr, 
table td {
  border-collapse: collapse;
  padding-left: 5px;
  padding-right: 5px;
}

/* Table headings are bold and centered */
tbody > th, 
th {
  text-align: center
  display: inline;
  font-weight: bold;
}

/* The following two styles are for zebra striping table rows. The first is
 * cleaner, but assumes no rowspans; the second relies on a class being
 * applied manually to such tables. */

tbody tr:nth-child(2n+1) {
    background-color: #F5F5F5;
}

tbody > tr.odd {
    background-color: #F5F5F5;
}

/* Table captions are similar to figure captions. They are centered below the
 * table, in a slightly smaller, italic font */
table > caption {
  caption-side: bottom;
  margin-top: 2%;
  padding-top: 2%;
  text-align: center;
  font-style: italic;
  font-size: 90%;
}

/*********** 
 *         *
 * LISTS   *
 *         *
 ***********/

dl.inline dt {
  display: run-in;
  padding-right: 1em;
}

/* Display a list as a comma-separated list of elements */
ul.comma li {
  display: inline;
  list-style-type: none;
}
ul.comma li:after {
 content: ", ";
}
ul.comma li:before {
 content: " ";
}
ul.comma li:last-child:after {
  content: "";
}

ul.comma li:last-child:before {
  content: " and ";
}

ul.comma { 
  display: inline;
  list-style-type: none;
}

body {
  font-style: normal;
  font-size: large;
  font-color: black;
  background-color: transparent; 
}

figcaption { display: none }
.fn {
  float: footnote;
  counter-increment: footnote;
}

p {
  text-indent: 1em;
}

article {
  counter-reset: footnote;
}

@page {
    @footnotes {
	border-top: solid black thin;
	padding-top: 8pt;
    }

    @top-center {
        content: 'Read Ruby 1.9 (DRAFT): http://ruby.runpaint.org/';
        font-weight: bold;
    }
    @bottom-center {
        content: counter(page);
	font-style: italic;
    }
    background: url('../www/draft.png') no-repeat fixed center;
}

@page:first { 
    @top { content: normal }
    @bottom-center { content: normal }
}

body > h1 {
  font-size: 1000%;
  text-transform: uppercase;
  text-align: center;
  line-height: 80%;
  font-weight: bold;
  margin: 0;
  padding-bottom: 5%;
}

body > p {
  text-align: center;
  font-size: 150%;
}

.fn::footnote-marker:after {
    content: ' - ';
}

    </xsl:text>    
  </xsl:template>

  <xsl:param name="out_dir">out</xsl:param>
  <xsl:output omit-xml-declaration="yes"/>
  <xsl:template match="d:book">
    <xsl:document href="{$out_dir}/single.html" 
		  method="html" 
		  doctype-public="XSLT-compat">
      <html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<xsl:call-template name="embed-css">
	  <xsl:with-param name="css">main</xsl:with-param>
	</xsl:call-template>
	<title>Read Ruby 1.9</title>
	<body>
	  <h1><xsl:value-of select="/d:book/d:title"/></h1>
	  <p>Free ebook about the Ruby 1.9 programming language</p>
	  <p><a href="http://ruby.runpaint.org/">ruby.runpaint.org</a></p>
	  <xsl:apply-templates/>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

  <xsl:template match="d:book/d:title"/>
  <xsl:template match="d:sect1/d:title|d:sect2/d:title|d:sect3/d:title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

  <!-- FootNote
       The contents of a footnote is included in a <footnote> element. The
       position of the element dictates where the footnote marker should appear.

       When we encounter a footnote element we insert a marker. The marker is
       an integer which is incremented each time a footnote is encountered, but
       reset for each chapter. Thus, the variable $mark specifies the footnote
       count for the current chapter. We wrap this marker in a <sub> so it
       displays correctly even without CSS. We link it to an anchor of the form
       '#fn-$mark'. This does not exist yet, but is created later by the
       _footnote-list_ template. It will contain the footnote's contents,
       i.e. the children of this <footnote>. Lastly, we give this link an ID of
       the form '#ref-$mark', so the '#fn-$mark' element can link back to it.
  -->
  <xsl:template match="d:footnote">
    <span class="fn"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="d:footnote/d:para">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="d:appendix[@xml:id='pun.punctuation']"/>
  <!-- Copy over all attributes -->
  <xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <!-- Copy text nodes and PIs -->
  <xsl:template match="text() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>
</xsl:stylesheet>

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
      <xsl:call-template name="footnote-list"/>
    </article>
  </xsl:template>

  <xsl:template name="main.css">
    <xsl:text disable-output-escaping="yes">
@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('../fonts/ttf/goudy_bookletter_1911-webfont.ttf');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Inconsolata';
	src: url('../fonts/ttf/Inconsolata-webfont.ttf');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Linux Libertine';
	src: url('../fonts/ttf/linlibertine_re-4.7.5-webfont.ttf');
	font-weight: normal;
	font-style: normal;
}

body {
  font-family: 'Linux Libertine O', 'Linux Libertine', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif, 'unifont';
}

code,
pre {
  font-family: 'Inconsolata', 'unifont', monospace;
  font-size: 90%;
}

h1,
h1 > code {
  font-family: 'Goudy Bookletter 1911', 'Linux Libertine O', 'Linux Libertine', Palatino, 
               'Palatino Linotype', 'Book Antiqua', Georgia, 'Times New Roman', 
               serif, 'unifont';
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
  margin: 0;
}
article > section > h1 {
  font-size: 200%;
  text-align: center;
}

article > section > section > h1 {
  font-size: 125%;
}

article > section > section > section > h1 {
  font-size: 110%;
/* font-style: italic; */ /* GB1911 distorts when italicised */
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
  background-color: white; 
}

figcaption { display: none }
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
	  <xsl:apply-templates/>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

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
    <xsl:variable name="mark"><xsl:number level="any"
					  from="d:chapter"/></xsl:variable>
    <xsl:variable name="chapter" select="ancestor::d:chapter[last()]/@xml:id"/>
    <xsl:variable name="anchor">
      <xsl:value-of select="concat('fn-', $chapter, $mark)"/>
    </xsl:variable>
    <sup id="ref-{$chapter}{$mark}"><a 
			     href="#{$anchor}"
			     class="fn"><xsl:value-of select="$mark"/></a></sup>
  </xsl:template>

  <!--
     This template generates the list of footnotes at the end of a chapter. It
     is called before the <body> tag is closed for chapters, glossaries,
     appendices, and bibliographies.

     We only need to generate a list if the current page is a chapter and it
     contains footnotes. (Of course, only a chapter should ever contain
     footnotes, but...).

     Because this template is called from the d:chapter template, it can locate
     this chapter's footnotes with the XPath './/d:footnote'. <xsl:for-each>
     yields each footnote in the order it appeared in the chapter. This is
     important, because we need to ensure each footnote is labelled with the
     number we assigned to its marker. This is achieved with <xsl:number>,
     which counts from 1, and resets at the beginning of a chapter.

     The payload of each footnote is copied to the corresponding <li>
     element. This <li> has an ID of 'fn-$n', so as to correlate with the
     target of the corresponding marker. Appended to the footnote is a link
     back to '#ref-$n', which is the ID of the marker.
  -->
  <xsl:template name="footnote-list">
    <xsl:if test="local-name() = 'chapter' and count(.//d:footnote) &gt; 0">
      <xsl:variable name="chapter" select="@xml:id"/>
      <footer>
	<h1>Footnotes</h1>
	
	<ol>
	  <xsl:for-each select=".//d:footnote">
	    <xsl:variable name="n"><xsl:number name="fn-list" 
					       from="d:chapter" 
					       level="any"/></xsl:variable>
	    <xsl:variable name="from" 
			  select="concat('fn-', $chapter, $n)"/>
	    <xsl:variable name="to" 
			  select="concat('ref-', $chapter, $n)"/>
	    <li id="{$from}">
	    <xsl:apply-templates select="./*"/>
	    <xsl:text> </xsl:text><a href="#{$to}" 
				     class="returner"
				     title="Return to where you left off">↩</a>
	  </li>
	  </xsl:for-each>
	</ol>
      </footer>
    </xsl:if>
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

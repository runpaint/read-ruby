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
  <xsl:include href="footnote.xsl"/>
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
  font-family: 'Linux Libertine', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif, 'unifont';
}

code,
pre {
  font-family: 'Inconsolata', 'unifont', monospace;
  font-size: 90%;
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

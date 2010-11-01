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
    <article class="{local-name()}" id="{@xml:id}">
      <h1><xsl:value-of select="d:title"/></h1>
      <xsl:apply-templates/>
    </article>
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
	  <xsl:with-param name="css">pdf</xsl:with-param>
	  <xsl:with-param name="omit_main">1</xsl:with-param>
	</xsl:call-template>
	<title>Read Ruby 1.9</title>
	<meta name="subject" content="A free ebook about Ruby 1.9"/>
	<meta name="keywords" content="ebook, ruby, 1.9, 1.9.2, programming, creative-commons, language"/>
	<meta name="date" content="{$git_date}"/>
	<meta name="author" content="Run Paint Run Run"/>
	<body>
	  <h1><xsl:value-of select="/d:book/d:title"/></h1>
	  <p>Free ebook about the Ruby 1.9 programming language</p>
	  <p><a href="http://ruby.runpaint.org/">ruby.runpaint.org</a></p>
	  <article class="toc">
	    <h1>Contents</h1>
	    <xsl:call-template name="toc-ol"/>
	  </article>
	  <xsl:apply-templates/>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

  <xsl:template match="d:book/d:title"/>
  <xsl:template match="d:sect1/d:title|d:sect2/d:title|d:sect3/d:title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

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

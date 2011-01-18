<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <xsl:template name="toc">
    <xsl:variable name="id" select="substring-after(@xml:id, '.')"/>
    <xsl:document href="{$out_dir}/toc.html" 
		  method="html" 
		  doctype-public="XSLT-compat">
      <html>
	<meta charset="utf-8"/>
	<xsl:call-template name="preamble"/>
	<xsl:call-template name="embed-css">
	  <xsl:with-param name="css">toc page</xsl:with-param>
	</xsl:call-template>
	<title>Table of Contents (Read Ruby 1.9)</title>
	<body>
	  <xsl:call-template name="header">
	    <xsl:with-param name="title">Contents</xsl:with-param>
	  </xsl:call-template>
	  <article class="toc">
	    <header>
	      <h1>Contents</h1>
	    </header>
	    <xsl:call-template name="toc-ol"/>
	  </article>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

  <xsl:template name="toc-ol">
    <xsl:for-each select="d:part">
      <h2><xsl:value-of select="d:title"/></h2>

      <ol>
	<xsl:for-each select="d:chapter|d:appendix">
	  <!-- TODO: Pass chapter name in as param -->
	  <xsl:call-template name="toc-entry"/>
	</xsl:for-each>
	<!-- TODO: Add biblio and gloss -->
      </ol>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="toc-entry">
    <xsl:if test="not(@xml:id)">
      <xsl:message><xsl:value-of select="d:title"/> has no ID</xsl:message>
    </xsl:if>
    <xsl:variable name="href">
      <xsl:call-template name="id-to-href">
	<xsl:with-param name="id" select="@xml:id"/>
	<xsl:with-param name="relative">0</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <!-- TODO: Fix empty titles by removing superflous text nodes -->
    <li><a href="{$href}"><xsl:apply-templates select="(d:title//.)[2]"/></a>
      <xsl:if test="d:sect1|d:sect2|d:sect3|d:sect4|d:sect5|d:section">
	<ol>
	  <xsl:for-each select="*">
	    <xsl:if test="starts-with(local-name(.), 'sect')">
	      <xsl:call-template name="toc-entry"/>
	    </xsl:if>
	  </xsl:for-each>
	</ol>
      </xsl:if>
    </li>
  </xsl:template>
</xsl:stylesheet>

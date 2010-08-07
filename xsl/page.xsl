<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- 
     A chapter, bibliography, appendix, and glossary create a new HTML
     page. The page name is that of the element's ID, minus the 4-character
     prefix. 
     
     The HTML5 doctype isn't supported by XSLT, so we use <!DOCTYPE HTML SYSTEM
     "about:legacy-compat">, as per
     http://www.whatwg.org/specs/web-apps/current-work/#the-doctype .

     The page content is enclosed in an <article> element whose class
     is the name of the element. Following the page content is a possible
     footnote list (see footnote.xsl).
  -->

  <xsl:template match="d:chapter|d:glossary">
    <xsl:call-template name="page">
      <xsl:with-param name="css">page syntax</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="d:bibliography|d:appendix">
    <xsl:call-template name="page">
      <xsl:with-param name="css">page</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="page">
    <xsl:param name="css"/>
    <xsl:variable name="id" select="substring-after(@xml:id, '.')"/>
    <xsl:document href="{$out_dir}/{$id}.html" 
		  method="html" 
		  doctype-system="about:legacy-compat">
      <html>
	<meta charset="utf-8"/>
	<title><xsl:value-of select="d:title"/> (Read Ruby 1.9)</title>
	<xsl:call-template name="preamble"/>
	<xsl:call-template name="embed-css">
	  <xsl:with-param name="css" select="$css"/>
	</xsl:call-template>
	<body>
	  <xsl:call-template name="header">
	    <xsl:with-param name="title" select="d:title"/>
	  </xsl:call-template>
	  <article class="{local-name()}">
	    <header>
	      <h1><xsl:value-of select="d:title"/></h1>
	      <nav>
		<ol>
		  <xsl:for-each select="d:sect1">
		    <xsl:variable name="section" 
				  select="substring-after(@xml:id, '.')"/>
		    <li><a href="#{$section}">
			<xsl:value-of select="d:title"/></a>
		    </li>
		  </xsl:for-each>
		</ol>
	      </nav>
	    </header>
	    <xsl:apply-templates/>
	    <xsl:call-template name="footnote-list"/>
	  </article>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

  <xsl:template name="header">
    <xsl:param name="title"/>

    <header>
      <h1><xsl:value-of select="$title"/></h1>
      <nav>
	<ol>
	  <!-- FIXME: Special-case when $title == 'Contents' -->
	  <li><a href="/toc">Read Ruby</a></li>
	  <li><xsl:value-of select="$title"/>
	    <xsl:text> </xsl:text>
	    <span>(draft)</span>
	  </li>
	</ol>
	<xsl:call-template name="search"/>
      </nav>
    </header>
  </xsl:template>
</xsl:stylesheet>

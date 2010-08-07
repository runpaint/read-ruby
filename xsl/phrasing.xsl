<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Emphasis -->
  <xsl:template match="d:emphasis">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <!-- Subscript -->
  <xsl:template match="d:subscript">
    <sub><xsl:apply-templates/></sub>
  </xsl:template>

  <!-- Superscript -->
  <xsl:template match="d:superscript">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>

  <!-- CiteTitle
       This is the title of a third-party work that we need to refer to without
       including it in the bibliography.
  -->
  <xsl:template match="d:citetitle">
    <cite><xsl:apply-templates/></cite>
  </xsl:template>

  <xsl:include href="literal.xsl"/>
  
  <xsl:template match="d:acronym">
    <abbr><xsl:apply-templates/></abbr>
  </xsl:template>
  <xsl:template match="d:remark"></xsl:template>
  <xsl:template match="d:firstterm"><dfn><xsl:apply-templates/></dfn></xsl:template>
  <xsl:template match="d:quote"><q><xsl:apply-templates/></q></xsl:template>
</xsl:stylesheet>

<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Figure/Example > Title
       We special-case the general d:title template when the parent is
       a <figure> or <example>. Both elements map to a <figure>, so the title
       must be rendered as a <figcaption>.
  -->
  <xsl:template match="d:figure/title|d:example/title">
    <figcaption><xsl:apply-templates/></figcaption>
  </xsl:template>

  <!-- Example -->
  <xsl:template match="d:example">
    <figure class="example"><xsl:apply-templates/></figure>
  </xsl:template>

  <xsl:template match="d:example/d:title">
    <figcaption><xsl:apply-templates/></figcaption>
  </xsl:template>

  <!-- InformalExample -->
  <xsl:template match="d:informalexample">
    <figure class="iexample"><xsl:apply-templates/></figure>
  </xsl:template>
</xsl:stylesheet>

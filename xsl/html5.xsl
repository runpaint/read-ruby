<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <xsl:param name="out_dir">out</xsl:param>
xs
  <xsl:output omit-xml-declaration="yes"/>

  <xsl:include href="bibliography.xsl"/>
  <xsl:include href="callout.xsl"/>
  <xsl:include href="css.xsl"/>
  <xsl:include href="epigraph.xsl"/>
  <xsl:include href="example.xsl"/>
  <xsl:include href="flow.xsl"/>
  <xsl:include href="footnote.xsl"/>
  <xsl:include href="glossary.xsl"/>
  <xsl:include href="index.xsl"/>
  <xsl:include href="list.xsl"/>
  <xsl:include href="link.xsl"/>
  <xsl:include href="page.xsl"/>
  <xsl:include href="phrasing.xsl"/>
  <xsl:include href="preamble.xsl"/>
  <xsl:include href="search.xsl"/>
  <xsl:include href="sitemap.xsl"/>
  <xsl:include href="table.xsl"/>
  <xsl:include href="toc.xsl"/>

  <xsl:template name="normalise-id">
    <xsl:param name="id"/>
    <xsl:value-of select="substring-after($id, '.')"/>
  </xsl:template>

  <!-- Copy over all attributes -->
  <xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <!-- For any element without a matching template rule, warn. -->
  <xsl:template match="*">
    <xsl:message>Unknown element <xsl:value-of select="local-name()"/></xsl:message>
  </xsl:template>

  <!-- Copy text nodes and PIs -->
  <xsl:template match="text() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>
</xsl:stylesheet>

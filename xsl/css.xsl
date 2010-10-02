<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:import href="main.css.xsl"/>
  <xsl:import href="syntax.css.xsl"/>
  <xsl:import href="toc.css.xsl"/>
  <xsl:import href="page.css.xsl"/>
  <xsl:import href="index.css.xsl"/>
  <xsl:import href="pdf.css.xsl"/>

  <xsl:template name="embed-css">
    <xsl:param name="css"/>
    <xsl:param name="omit_main"/>
    <style type="text/css">
      <xsl:if test="$omit_main != 1">
	<xsl:call-template name="main.css"/>
      </xsl:if>
      <xsl:if test="contains($css, 'page')">
	<xsl:call-template name="page.css"/>
      </xsl:if>
      <xsl:if test="contains($css, 'syntax')">
	<xsl:call-template name="syntax.css"/>
      </xsl:if>
      <xsl:if test="contains($css, 'index')">
	<xsl:call-template name="index.css"/>
      </xsl:if>
      <xsl:if test="contains($css, 'toc')">
	<xsl:call-template name="toc.css"/>
      </xsl:if>
      <xsl:if test="contains($css, 'pdf')">
	<xsl:call-template name="pdf.css"/>
      </xsl:if>
    </style>
  </xsl:template>
</xsl:stylesheet>

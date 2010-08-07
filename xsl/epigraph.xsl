<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Epigraph / Blockquote 
       
       Both elements are rendered as blockquotes, with a _class_ attribute to
       distinguish them for the purposes of CSS. They are expected to have an
       _attribution_ child, which is displayed below the quotation.
    -->
  <xsl:template match="d:epigraph|d:blockquote">
    <blockquote class="{local-name()}">
      <xsl:apply-templates/>

      <p><xsl:apply-templates select="d:attribution/*"/></p>
    </blockquote>
  </xsl:template>

  <!-- Epigraph/Blockquote > Attribution-->
  <xsl:template match="d:epigraph/d:attribution|d:blockquote/d:attribution"/>
</xsl:stylesheet>

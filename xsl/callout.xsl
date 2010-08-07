<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Note -->
  <xsl:template match="d:note">
    <aside class="note">
      <xsl:apply-templates/>
    </aside>
  </xsl:template>

  <!-- Sidebar -->
  <xsl:template match="d:sidebar">
    <aside class="sidebar">
      <xsl:apply-templates/>
    </aside>
  </xsl:template>
</xsl:stylesheet>

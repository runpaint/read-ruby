<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
		xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <xsl:template name="sitemap">
    <xsl:document href="{$out_dir}/sitemap.xml" mode="xml">
      <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
	<xsl:call-template name="sitemap-url"/>
	<xsl:call-template name="sitemap-url">
	  <xsl:with-param name="path">toc</xsl:with-param>
	</xsl:call-template>
	<xsl:for-each select="//d:chapter|d:glossary|d:bibliography|d:appendix">
	  <xsl:call-template name="sitemap-url">
	    <xsl:with-param name="path">
	      <xsl:call-template name="id-to-chapter">
		<xsl:with-param name="id" select="@xml:id"/>
	      </xsl:call-template>
	    </xsl:with-param>
	  </xsl:call-template>	
	</xsl:for-each>
	<xsl:for-each select="//d:example|d:informalexample">
	  <xsl:call-template name="sitemap-url">
	    <xsl:with-param name="path">
	      <xsl:value-of select="concat('examples/', 
				    substring-after(@xml:id, '.'), '.rb')"/>
	    </xsl:with-param>
	  </xsl:call-template>	
	</xsl:for-each>
      </urlset>
    </xsl:document>
  </xsl:template>
  
  <xsl:template name="sitemap-url">
    <xsl:param name="path"/>
    <url>
      <loc>http://ruby.runpaint.org/<xsl:value-of select="$path"/></loc>
    </url>    
  </xsl:template>
</xsl:stylesheet>

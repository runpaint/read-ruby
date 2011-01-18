<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>
  <!-- Sect\d -->
  <xsl:template match="d:sect1|d:sect2|d:sect3|d:sect4|d:sect5">
    <xsl:variable name="id">
      <xsl:call-template name="normalise-id">
	<xsl:with-param name="id" select="@xml:id"/>
      </xsl:call-template>
    </xsl:variable>

    <section id="{$id}"><xsl:apply-templates/></section>
  </xsl:template>

  <xsl:template match="d:methodsynopsis">
    <!-- FIXME: <code> should be <var> but that's also italic -->
    <code><b><xsl:value-of select="d:methodname"/></b><xsl:text>(</xsl:text>

    <xsl:for-each select="d:methodparam/d:parameter">
      <xsl:choose>
       <!-- If this is a block paramater, we want to display it after
       the parenthesised argument list, so we insert the closing
       parenthesis before rendering the block. -->
       <xsl:when test="starts-with(., '{')">
         <xsl:text>) </xsl:text>
       </xsl:when>
       <!-- The parameters inside the parentheses should be displayed
       as a comma-separated list. Before we render a parameter, we
       check that there was a preceding parameter, then render the
       comma that follows the last one. However, if this is a block
       parameter, the last parameter was effectively the final one in
       this list, so it doesn't need a comma to follow
       it.-->
       <xsl:when test="position() &gt; 1">
         <xsl:text>,&#160;</xsl:text>
       </xsl:when>
      </xsl:choose>
       <!-- Optional paramaters are italicised; require parameters are bolded. -->

	<xsl:choose>
	  <xsl:when test="../@choice = 'opt'">
	    <i><xsl:apply-templates/></i>
	  </xsl:when>
	  <xsl:otherwise>
	    <b><xsl:apply-templates/></b>
	  </xsl:otherwise>
	</xsl:choose>

      <!-- Optional parameters are followed by ", ..." -->
      <xsl:if test="../@rep = 'repeat'">,&#160;…</xsl:if>
  
      <!-- After rendering the last non-block parameter close the
	   parenthesised argument list -->
      <xsl:if test="last() = position() and not(starts-with(., '{'))">
	<xsl:text>) </xsl:text>
      </xsl:if>
    </xsl:for-each>

      <!-- If there were no parameters the block above will never
	   execute, so the argument list wouldn't get closed; do that
	   now. -->
    <xsl:if test="d:void">
      <xsl:text>)</xsl:text>

    </xsl:if>

    <!-- Finally, print the return value. This synopsis may be
	 followed by another, or the textual description. Both must be
	 preceded by a line break. -->
    <xsl:text> #=&gt; </xsl:text><xsl:value-of select="d:type"/></code><br/>
  </xsl:template>

  <!-- Don't display; we handle this element above -->
  <xsl:template match="d:methodsynopsis/d:type"/>
  
  <!-- Don't display; we handle this element above -->
  <xsl:template match="d:methodsynopsis/d:methodparam"/>

  <xsl:template match="d:methodsynopsis/d:methodparam/d:parameter">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Don't display; we handle this element above -->
  <xsl:template match="d:methodsynopsis/d:void"/>

  <!-- Don't display; we handle this element above -->
  <xsl:template match="d:methodsynopsis/d:methodname"/>
  
  <xsl:template match="d:para/d:parameter">
    <var><xsl:apply-templates/></var>
  </xsl:template>

  <xsl:template match="d:exceptionname">
    <code><xsl:apply-templates/></code>
  </xsl:template>

  <xsl:template match="d:para[@xml:id]">
    <xsl:variable name="id">
      <xsl:call-template name="id-to-section">
	<xsl:with-param name="id" select="@xml:id"/>
      </xsl:call-template>
    </xsl:variable>

    <p id="{$id}"><xsl:call-template name="para"/></p>
  </xsl:template>

  <xsl:template match="d:para">
    <p><xsl:call-template name="para"/></p>
  </xsl:template>

  <xsl:template name="para"><xsl:apply-templates/></xsl:template>

  <!-- Title 
       Generally, a <title> is converted to a <h1>. This works because HTML5
       allows multiple <h1>s in a single document, with their level dicated by
       the enclosing context.
  -->
  <xsl:template match="d:title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

  <xsl:template match="d:sect1/d:title|d:sect2/d:title|d:sect3/d:title">
    <xsl:variable name="id">
      <xsl:call-template name="normalise-id">
	<xsl:with-param name="id" select="../@xml:id"/>
      </xsl:call-template>
    </xsl:variable>
    <h1><a href="#{$id}" title="permalink">§</a>
      <xsl:text> </xsl:text>
      <xsl:apply-templates/></h1>
  </xsl:template>
  
  <!-- 
     The title of a <chapter>, <glossary>, <bibliography>, and <appendix> is
     displayed as part of the page template (see page.xsl), so here we ignore
     it.
  -->
  <xsl:template match="d:chapter/d:title"/>
  <xsl:template match="d:glossary/d:title"/>
  <xsl:template match="d:bibliography/d:title"/>
  <xsl:template match="d:appendix/d:title"/>
  
  <!-- Ignore <part>s for now, but process their contents -->
  <xsl:template match="d:part">
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>

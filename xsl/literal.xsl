<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>
  
  <!-- Filename -->
  <xsl:template match="d:filename">
    <code class="filename"><xsl:apply-templates/></code>
  </xsl:template>

  <!-- Keycombo -->
  <xsl:template match="d:keycombo">
    <kbd><xsl:apply-templates/></kbd>
  </xsl:template>

  <!-- Keycombo > keycap-->
  <xsl:template match="d:keycombo/d:keycap">
    <kbd><xsl:apply-templates/></kbd>
    <xsl:if test="following-sibling::d:keycap">+</xsl:if>
  </xsl:template>

  <!-- Keycap -->
  <xsl:template match="d:keycap">
    <kbd><xsl:apply-templates/></kbd>
  </xsl:template>

  <!-- Literal -->
  <xsl:template match="d:literal">
    <code><xsl:apply-templates/></code>
  </xsl:template>

  <!-- Code -->
  <xsl:template match="d:code">
    <code><xsl:apply-templates/></code>
  </xsl:template>

  <!-- Option -->
  <xsl:template match="d:option">
    <code class="option"><xsl:apply-templates/></code>
  </xsl:template>

  <!-- EnVar -->
  <xsl:template match="d:envar">
    <code class="envar"><xsl:apply-templates/></code>
  </xsl:template>

  <!-- Function -->
  <xsl:template match="d:function">
    <code class="function"><xsl:apply-templates/></code>
  </xsl:template>

  <!-- Command -->
  <xsl:template match="d:command">
    <code class="command"><xsl:apply-templates/></code>
  </xsl:template>
  
  <!-- ProgramListing -->
  <xsl:template match="d:programlisting">
    <pre><code class="ruby"
	       id="{../@xml:id}"><xsl:apply-templates /></code></pre>
  </xsl:template>
 
  <!-- ComputerOutput -->
  <xsl:template match="d:computeroutput">
    <samp><xsl:apply-templates/></samp>
  </xsl:template>

  <!-- Replaceable -->
  <xsl:template match="d:replaceable">
    <var><xsl:apply-templates/></var>
  </xsl:template>
</xsl:stylesheet>

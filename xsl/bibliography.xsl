<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Bibliography
       The bibliography consists of <bibliodiv>s containing one or
       more <biblioentry>s.
  -->
  
  <!-- BiblioDiv 
       This is simply a grouping of <biblioentry>s with a <title>. The latter
       is handled by our generic d:title template.
  -->
  <xsl:template match="d:bibliodiv">
    <section><xsl:apply-templates/></section>
  </xsl:template>

  <!-- BiblioEntry 
       The children of this element hold the metadata for the entry. To ensure
       consistent formatting, we transclude the values of children in the order
       we require. Accordingly, the templates for the children themselves are
       empty.
  -->
  <xsl:template match="d:biblioentry">
    <xsl:variable name="id">
      <xsl:call-template name="normalise-id">
	<xsl:with-param name="id" select="@xml:id"/>
      </xsl:call-template>
    </xsl:variable>

    <section id="{$id}">
      <h1><xsl:value-of select="d:abbrev"/></h1>
      
      <p><cite><xsl:value-of select="d:title"/></cite>;<xsl:text> </xsl:text>
	<xsl:call-template name="biblio-authorgroup"/>; 
	<xsl:value-of select="d:pubdate"/>; 
	<xsl:value-of select="d:publisher/d:publishername"/></p>
    </section>
  </xsl:template>

  <!-- 
     The list of authors for a given <biblioentry> may be represented as a
     single <author>/<editor> child of <biblioentry>, or one or more <author>
     children of an <authorgroup>. An <author>/<editor> element which
     represents a person, contains a single <personname> child. If an <author>
     element represents an organisation, instead, it will contain a
     single <orgname> child. The <personname> element, if present, contains the
     siblings <firstname> and <surname>.

     For the above scenarios, this template returns a comma-separated list of
     authors. The references to position() below are—aside from, surely, being
     horribly convoluted—an attempt at correct grammar:

     * A list of one author is printed as-is.
     * A list of two authors are joined with ' and '.
     * Otherwise, every author name but the last is followed by ', ', and the
     last is preceded by 'and '.
  -->
  <xsl:template name="biblio-authorgroup">
    <xsl:for-each select="(d:authorgroup/d:author|d:author|d:editor)">
      <xsl:if test="(position() &gt; 1) and (last() &gt; 2)">, </xsl:if>
      <xsl:if test="(position() = last()) and (last() &gt; 1)"> and </xsl:if>
      <xsl:choose>
	<xsl:when test="d:personname">
	  <xsl:value-of select="concat(d:personname/d:firstname, 
				' ', 
				d:personname/d:surname)"/>
	</xsl:when>
	<xsl:when test="d:orgname">
	  <xsl:value-of select="d:orgname"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


  <!-- BiblioEntry > Title -->
  <xsl:template match="d:biblioentry/d:title"/>
  <!-- BiblioEntry > Abbrev -->
  <xsl:template match="d:biblioentry/d:abbrev"/>
  <!-- BiblioEntry > Author -->
  <xsl:template match="d:biblioentry/d:author"/>
  <!-- BiblioEntry > AuthorGroup -->
  <xsl:template match="d:biblioentry/d:authorgroup"/>
  <!-- BiblioEntry > PubDate -->
  <xsl:template match="d:biblioentry/d:pubdate"/>
  <!-- BiblioEntry > BiblioID -->
  <xsl:template match="d:biblioentry/d:biblioid"/>

</xsl:stylesheet>

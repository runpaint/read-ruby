<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Glossary
       The <glossary> element is handled in the general HTML page
       template. Here we process its children.
  -->

  <!-- GlossEntry 
       A <glossentry> encloses a <glossterm> and either a <glossdef> or
       a <glosssee>. Ideally, we represent each of these as a <dt>/<dd> pair,
       but that complicates the logic of our HTML page template. So, for now,
       we just wrap them in a <section> element.
  -->
  <xsl:template match="d:glossary/d:glossentry">
    <section>
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <!-- GlossTerm 
       The semantics of a <glossterm> depend on whether it has a @linkend
       attribute. If it does, it appears outside of a <glossentry>, and is
       handled by the template in link.xsl. Otherwise, it appears inside of
       a <glossentry> and specifies the term being defined.
  -->
  <xsl:template match="d:glossentry/d:glossterm">
    <xsl:variable name="id" select="substring-after(../@xml:id, 'glo.')"/>
    <h1 id="{$id}"><xsl:apply-templates/></h1>
  </xsl:template>

  <!-- GlossDef 
       A <glossdef> contains the definition of the preceding <glossterm>. It is
       replaced with its contents.

       If a <glossdef> contains any <glossseealso> links, they are displayed in
       a list below the definition.
  -->
  <xsl:template match="d:glossentry/d:glossdef">
    <xsl:apply-templates/>
    <xsl:if test="d:glossseealso">
      <p>See also: <ul>
	  <xsl:for-each select="d:glossseealso">
	    <xsl:variable name="linkend" select="@linkend"/>
	    <xsl:variable name="id" select="substring-after($linkend, 'glo.')"/>
	    <xsl:variable name="anchor" select="//*[@xml:id = $linkend][1]"/>
	    <li><a href="#{$id}"><xsl:apply-templates select="$anchor/d:glossterm/*"/></a></li>
	  </xsl:for-each>
      </ul></p>
    </xsl:if>
  </xsl:template>

  <!-- GlossSeeAlso 
       The <glossseealso> elements descending from a <glossdef> are rendered by
       the <glossdef> template, so here we just ignore them.
  -->
  <xsl:template match="d:glossseealso"/>

  <!-- GlossSee 
       The <glosssee> element specifies that the preceding <glossterm> is
       defined in another <glossentry>. It identifies the ID of the other entry
       with the @otherterm attribute.

       It is rendered as a hyperlink contained in a paragraph. The link text is
       the contents of @otherterm's <glossterm>, and the link URL is @otherterm
       with the 'glo.' prefix removed.
  -->
  <xsl:template match="d:glossentry/d:glosssee">
    <xsl:variable name="otherterm" select="@otherterm"/>
    <xsl:variable name="anchor" select="//*[@xml:id = $otherterm][1]"/>
    <xsl:variable name="id" select="substring-after($otherterm, 'glo.')"/>

    <xsl:if test="not(local-name($anchor/*[1]) = 'glossterm')">
      <xsl:message terminate="yes">
	GlossSee to <xsl:value-of select="$otherterm"/> has no title
      </xsl:message>
    </xsl:if>
    
    <p>See: <a href="#{$id}"><xsl:apply-templates select="$anchor/d:glossterm/*"/></a></p>
  </xsl:template>
</xsl:stylesheet>

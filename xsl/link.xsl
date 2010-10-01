<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                xmlns:xlink="http://www.w3.org/1999/xlink"
		exclude-result-prefixes="db ng exsl exslt d xlink"
                version='1.0'>

  <!-- BiblioRef
       A <biblioref> is a link to an entry in the bibliography. The majority of
       the formatting is handled by the biblioref-link template. If the
       <biblioref> is enclosed in an <attribution> element, it reflects the
       source of a <blockquote>/<epigraph>, so we preceded it with an em-dash;
       otherwise it is an in-text citation, so we enclose it in square
       brackets.
   -->
  <xsl:template match="d:biblioref">
    <xsl:choose>
      <xsl:when test="ancestor::d:attribution">
	<!-- TODO: Use author name, not abbreviation, for this form -->
	—<xsl:call-template name="biblio-link"/>
      </xsl:when>
      <xsl:otherwise>
	[<xsl:call-template name="biblio-link"/>]	
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--  
     This template creates an <a> link from a <biblioref> element. The link
     target is an anchor on the '/bibliography' page, described by the @linkend
     attribute. This has the form 'bib.id', where 'bib.' is a constant
     prefix. To generate the ID of the corresponding <biblioentry>, we must
     remove this prefix, storing the result in $id. The link text is the same
     as $id, with the initial letter capitalised.

     If the <biblioref> specifies a set of pages between @begin and @end, we
     append "pp. @begin–@end" to the link.

     TODO: Extract <abbrev> from <biblioentry> instead of generating it
     out-of-band.
  -->
  <xsl:template name="biblio-link">
    <xsl:variable name="id" select="substring-after(@linkend, 'bib.')"/>
    <xsl:variable name="first" select="translate(substring($id, 1, 1),
				                 'abcdefghijklmnopqrstuvwxyz', 
                                                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:variable name="abbrev" select="concat($first, substring($id, 2))"/>
    <xsl:variable name="pages">
      <!-- TODO: Special-case @begin == @end -->
      <xsl:if test="@begin">, pp.
	<xsl:value-of select="@begin"/>–<xsl:value-of select="@end"/>
      </xsl:if>
    </xsl:variable>
    
    <a href="/bibliography#{$id}"><xsl:value-of select="$abbrev"/></a>
    <xsl:value-of select="$pages"/>
  </xsl:template>

  <!-- Link (@linkend) 
       A <link> element with a @linkend attribute is an internal link to the
       given ID. It may have contents. Its target is an ID of the form
       'cha.section', where 'cha' is a 3-letter abbreviation of a chapter, and
       'section' an anchor within that chapter. We convert this ID to a URL
       with the linkend-to-href template.
  -->
  <xsl:template match="d:link[@linkend]">
    <xsl:variable name="linkend" select="@linkend"/>
    <xsl:variable name="href">
      <xsl:call-template name="id-to-href">
	<xsl:with-param name="id" select="@linkend"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="normalize-space(.)">
	<a href="{$href}"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:otherwise>
	<a href="{$href}"><xsl:value-of select="id($linkend)/d:title"/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Link (XLink) 
       A <link> element with an @xlink:href attribute is an external link to the
       given URL. It may have contents. We convert this to an <a> element.
  -->
  <xsl:template match="d:link[@xlink:href]">
    <xsl:variable name="href" select="@xlink:href"/>
    <xsl:if test="not(normalize-space(.))">
      <xsl:message>link to <xsl:value-of select="$href"/> is empty</xsl:message>
    </xsl:if>
    <a href="{$href}"><xsl:apply-templates/></a>
  </xsl:template>

  <!-- Xref 
       An <xref> is similar to a <link> except it is empty. Its link text is
       derived from its target. If the target has a <title> child, we use the
       contents of that; if it has a <caption> child, like a <table> does, we
       use the contents of that, instead. Again, we generate the target URL
       with the linkend-to-href template.
  -->
  <xsl:template match="d:xref">
    <xsl:variable name="linkend" select="@linkend"/>
    <xsl:variable name="anchor" select="//*[@xml:id = $linkend][1]"/>
    <xsl:variable name="title">
      <xsl:choose>
	<xsl:when test="local-name($anchor/*[1]) = 'title'">
	  <xsl:apply-templates select="$anchor/*[1]"/>
	</xsl:when>
	<xsl:when test="local-name($anchor/*[1]) = 'caption'">
	  <xsl:apply-templates select="$anchor/*[1]"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:message terminate="yes">
	    Xref to <xsl:value-of select="$linkend"/> has no title
	  </xsl:message>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="href">
      <xsl:call-template name="id-to-href">
	<xsl:with-param name="id" select="@linkend"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- TODO: Should we be using value-of? Surely this loses any markup the
	 title contains? -->
    <a class="xref" href="{$href}"><xsl:value-of select="$title"/></a>
  </xsl:template>

  <!-- GlossTerm (link) 
       A <glossterm> that doesn't descend from <glossary> is a link to
       a <glossentry>; otherwise, it has another role (see: glossary.xsl). The
       two forms are distinguished by the presence of a @linkend attribute: the
       former has one, the latter does not. If the <glossterm> has content,
       that becomes the link text. Otherwise, the link text is the contents of
       the <glossterm> child of the referenced <glossentry>. The link URL is,
       again, generated by the linkend-to-href template.
  -->

  <xsl:template match="d:glossterm[@linkend]">
    <xsl:variable name="href">
      <xsl:call-template name="id-to-href">
	<xsl:with-param name="id" select="@linkend"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="normalize-space(.)">
	<a class="glossterm" href="{$href}"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:otherwise>
	<xsl:variable name="linkend" select="@linkend"/>
	<xsl:variable name="anchor" select="//*[@xml:id = $linkend][1]"/>
	<xsl:variable name="id" select="substring-after($linkend, 'glo.')"/>
	<xsl:if test="not(local-name($anchor/*[1]) = 'glossterm')">
	  <xsl:message terminate="yes">
	    GlossTerm to <xsl:value-of select="$linkend"/> has no title
	  </xsl:message>
	</xsl:if>
	
	<a class="glossterm" href="{$href}"><xsl:apply-templates select="$anchor/d:glossterm/*"/></a>	
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
     The templates below convert an ID of the form 'cha.section', where 'cha'
     is a 3-letter abbreviation for a page, and 'section' an anchor with that
     page, to a URL. The URL has the form '/chapter#section', where 'chapter'
     is the page name corresponding to 'cha'.
  -->
  <xsl:template name="id-to-chapter">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="starts-with($id, 'pro.')">programs</xsl:when>
      <xsl:when test="starts-with($id, 'var.')">variables</xsl:when>
      <xsl:when test="starts-with($id, 'mes.')">messages</xsl:when>
      <xsl:when test="starts-with($id, 'obj.')">objects</xsl:when>
      <xsl:when test="starts-with($id, 'cla.')">classes</xsl:when>
      <xsl:when test="starts-with($id, 'mod.')">modules</xsl:when>
      <xsl:when test="starts-with($id, 'met.')">methods</xsl:when>
      <xsl:when test="starts-with($id, 'clo.')">closures</xsl:when>
      <xsl:when test="starts-with($id, 'enc.')">encoding</xsl:when>
      <xsl:when test="starts-with($id, 'enu.')">enumerables</xsl:when>
      <xsl:when test="starts-with($id, 'arr.')">arrays</xsl:when>
      <xsl:when test="starts-with($id, 'fil.')">files</xsl:when>
      <xsl:when test="starts-with($id, 'flo.')">flow</xsl:when>
      <xsl:when test="starts-with($id, 'exc.')">exceptions</xsl:when>
      <xsl:when test="starts-with($id, 'num.')">numerics</xsl:when>
      <xsl:when test="starts-with($id, 'str.')">strings</xsl:when>
      <xsl:when test="starts-with($id, 'reg.')">regexps</xsl:when>
      <xsl:when test="starts-with($id, 'io.')">io</xsl:when>
      <xsl:when test="starts-with($id, 'pun.')">punctuation</xsl:when>
      <xsl:when test="starts-with($id, 'glo.')">glossary</xsl:when>
      <xsl:when test="starts-with($id, 'bib.')">bibliography</xsl:when>
      <xsl:when test="starts-with($id, 'ex.')"></xsl:when>
      <xsl:otherwise>
	<xsl:message terminate="yes">
	  Unknown link target '<xsl:value-of select="."/>'. id=<xsl:value-of select="$id"/>
	</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="id-to-section">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="starts-with($id, 'ex.')">
	<xsl:value-of select="$id"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="substring-after($id, '.')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
     Given an element ID, derive its URL. If the _relative_ parameter is 1, the
     URL may be relative; otherwise it will be absolute.
  -->
  <xsl:template name="id-to-href">
    <xsl:param name="id"/>
    <xsl:param name="relative">1</xsl:param>

    <xsl:variable name="chapter">
      <xsl:call-template name="id-to-chapter">
	<xsl:with-param name="id" select="$id"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="section">
      <xsl:call-template name="id-to-section">
	<xsl:with-param name="id" select="$id"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="($relative = 1) or ($only_rel_links = 1)">
	<xsl:call-template name="make-shortest-href">
	  <xsl:with-param name="chapter" select="$chapter"/>
	  <xsl:with-param name="section" select="$section"/>
	  <xsl:with-param name="id" select="$id"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="make-absolute-href">
	  <xsl:with-param name="chapter" select="$chapter"/>
	  <xsl:with-param name="section" select="$section"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
     Given a chapter and section, construct an absolute URL to it.
  -->
  <xsl:template name="make-absolute-href">
    <xsl:param name="chapter"/>
    <xsl:param name="section" select="$chapter"/>

    <xsl:choose>
      <xsl:when test="$section = $chapter">
	<xsl:value-of select="concat('/', $chapter)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="concat('/', $chapter, '#', $section)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
     Given a chapter and section, construct a relative URL to it.
  -->
  <xsl:template name="make-relative-href">
    <xsl:param name="chapter"/>
    <xsl:param name="section"/>

    <xsl:value-of select="concat('#', $section)"/>
  </xsl:template>

  <!-- 
     Given a chapter, ID, and section, construct the shortest URL to it:

     * If the element is within the current chapter, create a relative URL.
     * If the element is an example, create a relative URL.
     * Otherwise, make an absolute URL.
  -->
  <xsl:template name="make-shortest-href">
    <xsl:param name="chapter"/>
    <xsl:param name="section"/>
    <xsl:param name="id"/>

    <xsl:choose>
      <xsl:when test="ancestor::d:chapter[last()]//*[@xml:id = $id]">
	<xsl:call-template name="make-relative-href">
	  <xsl:with-param name="chapter" select="$chapter"/>
	  <xsl:with-param name="section" select="$section"/>
	</xsl:call-template>
      </xsl:when>
      <!-- FIXME: Stop assuming example is in current chapter -->
      <xsl:otherwise>
	<xsl:call-template name="make-absolute-href">
	  <xsl:with-param name="chapter" select="$chapter"/>
	  <xsl:with-param name="section" select="$section"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

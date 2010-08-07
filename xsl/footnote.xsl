<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- FootNote
       The contents of a footnote is included in a <footnote> element. The
       position of the element dictates where the footnote marker should appear.

       When we encounter a footnote element we insert a marker. The marker is
       an integer which is incremented each time a footnote is encountered, but
       reset for each chapter. Thus, the variable $mark specifies the footnote
       count for the current chapter. We wrap this marker in a <sub> so it
       displays correctly even without CSS. We link it to an anchor of the form
       '#fn-$mark'. This does not exist yet, but is created later by the
       _footnote-list_ template. It will contain the footnote's contents,
       i.e. the children of this <footnote>. Lastly, we give this link an ID of
       the form '#ref-$mark', so the '#fn-$mark' element can link back to it.
  -->
  <xsl:template match="d:footnote">
    <xsl:variable name="mark"><xsl:number level="any"
					  from="d:chapter"/></xsl:variable>
    <xsl:variable name="anchor">
      <xsl:value-of select="concat('fn-', $mark)"/>
    </xsl:variable>
    <sup id="ref-{$mark}"><a 
			     href="#{$anchor}"
			     class="fn"><xsl:value-of select="$mark"/></a></sup>
  </xsl:template>

  <!--
     This template generates the list of footnotes at the end of a chapter. It
     is called before the <body> tag is closed for chapters, glossaries,
     appendices, and bibliographies.

     We only need to generate a list if the current page is a chapter and it
     contains footnotes. (Of course, only a chapter should ever contain
     footnotes, but...).

     Because this template is called from the d:chapter template, it can locate
     this chapter's footnotes with the XPath './/d:footnote'. <xsl:for-each>
     yields each footnote in the order it appeared in the chapter. This is
     important, because we need to ensure each footnote is labelled with the
     number we assigned to its marker. This is achieved with <xsl:number>,
     which counts from 1, and resets at the beginning of a chapter.

     The payload of each footnote is copied to the corresponding <li>
     element. This <li> has an ID of 'fn-$n', so as to correlate with the
     target of the corresponding marker. Appended to the footnote is a link
     back to '#ref-$n', which is the ID of the marker.
  -->
  <xsl:template name="footnote-list">
    <xsl:if test="local-name() = 'chapter' and count(.//d:footnote) &gt; 0">
      <footer>
	<h1>Footnotes</h1>
	
	<ol>
	  <xsl:for-each select=".//d:footnote">
	    <xsl:variable name="n"><xsl:number name="fn-list" 
					       from="d:chapter" 
					       level="any"/></xsl:variable>
	    <xsl:variable name="from" 
			  select="concat('fn-', $n)"/>
	    <xsl:variable name="to" 
			  select="concat('ref-', $n)"/>
	    <li id="{$from}">
	    <xsl:apply-templates select="./*"/>
	    <xsl:text> </xsl:text><a href="#{$to}" 
				     class="returner"
				     title="Return to where you left off">↩</a>
	  </li>
	  </xsl:for-each>
	</ol>
      </footer>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>

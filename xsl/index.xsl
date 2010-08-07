<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>


  <!-- Book 
       The <book> element is at the root of the hierarchy. Its children are
       processed by the other templates, so here we construct index.html.

       This page is mostly static content. The dynamic part is the chapter list
       and second-level headings.
  -->
  <xsl:template match="d:book">
    <xsl:call-template name="toc"/>
    <xsl:call-template name="sitemap"/>
    <xsl:variable name="id" select="substring-after(@xml:id, '.')"/>
    <xsl:document href="{$out_dir}/index.html" 
		  method="html" 
		  doctype-public="XSLT-compat">
      <html>
	<meta charset="utf-8"/>
	<xsl:call-template name="preamble"/>
	<xsl:call-template name="embed-css">
	  <xsl:with-param name="css">main index</xsl:with-param>
	</xsl:call-template>
	<title>Read Ruby 1.9: Free Ebook About the Ruby Programming Language</title>
	<body>
	  <header>
	    <img src="/small-strawberry" alt="small strawberry" width="197" height="216"/>
	    <h1><xsl:value-of select="d:title"/></h1>
	    
	    <p><em>Very</em> early draft of a book about version 1.9 of the Ruby
	    programming language, released under a <a 
	    href="//creativecommons.org/licenses/by-nc-sa/2.0/uk/" 
            rel="license">Creative Commons license</a>. <small>Photo credit: <a 
            href="//www.flickr.com/photos/matthiasr/">Matthias
	    Richwin</a></small> <xsl:call-template name="search"/></p>
	    <ul>
	      <li><a href="mailto:runrun@runpaint.org">E-mail</a> author.</li>
	      <li>Browse <a href="//github.com/runpaint/read-ruby">source</a>.</li>
	      <li>Submit <a href="//github.com/runpaint/read-ruby/issues">bug report</a>.</li>
	    </ul>
	  </header>
	  
	  <section style="clear:both">
	    <h1>Contents</h1>

	    <ol>
	      <xsl:for-each select="//d:chapter">
		<xsl:variable name="ch">
		  <xsl:call-template name="id-to-href">
		    <xsl:with-param name="id" select="@xml:id"/>
		    <xsl:with-param name="relative" select="0"/>
		  </xsl:call-template>
		</xsl:variable>
		<li><a href="{$ch}"><xsl:value-of select="d:title"/></a>
		  <ol>
		    <xsl:for-each select="d:sect1">
		      <xsl:variable name="sec">
			<xsl:call-template name="id-to-href">
			  <xsl:with-param name="id" select="@xml:id"/>
			  <xsl:with-param name="relative" select="0"/>
			</xsl:call-template>
		      </xsl:variable>
		      <li><a href="{$sec}"><xsl:value-of select="d:title"/></a>
		      </li>
		    </xsl:for-each>
		  </ol>
		</li>
	      </xsl:for-each>
	      <xsl:for-each select="d:glossary|d:bibliography">
		<xsl:variable name="sec">
		  <xsl:call-template name="id-to-href">
		    <xsl:with-param name="id" select="@xml:id"/>
		    <xsl:with-param name="relative" select="0"/>
		  </xsl:call-template>
		</xsl:variable>
		<li><a href="{$sec}"><xsl:value-of select="d:title"/></a>
		</li>
	      </xsl:for-each>
	    </ol>
	    <p>(<a rel="index" href="/toc">complete</a> table of contents)</p>
	  </section>
	</body>
      </html>
    </xsl:document>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Book > Title
       This is already rendered as part of the d:book template, so we ignore it
       here.
  -->
  <xsl:template match="d:book/d:title"/>
</xsl:stylesheet>

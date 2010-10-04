<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Lists
       A list is typically a group of <listitem> elements, each of which maps
       to an <li> element in HTML. However, each <listitem> contains at least
       one <para>. If we convert <listitem><para>P</para></listitem>
       to <li><p>P</p></li>, lists consume too much vertical space. We could
       remove this with CSS, however currently we just move the contents of the
       <para> to its parent, then remove the <para>. TODO: Investigate the
       effects on <listitem>s containing multiple <para>s. -->
  <xsl:template match="d:listitem"><li><xsl:apply-templates/></li></xsl:template>
  <xsl:template match="d:listitem/d:para"><xsl:apply-templates/></xsl:template>

  <!-- ItemizedList -->
  <xsl:template match="d:itemizedlist">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <!-- OrderedList -->
  <xsl:template match="d:orderedlist">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  

  <!-- VariableList
       A VariableList is more complicated. It is a collection
       of <varlistentry>s, each of which contain a <term> and <listitem> as
       children. This maps to a <dl> in HTML, except the <varlistentry> layer
       is unnecessary. So, <term> converts to <dt>, <listitem> to <dd>,
       and <varlistentry> to its contents.
  -->
  <xsl:template match="d:variablelist">
    <xsl:if test="d:title">
      <h2><xsl:value-of select="d:title"/></h2>
    </xsl:if>
    
    <xsl:variable name="spacing" select="@spacing"/>
    <dl class="{$spacing}">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>
  
  <xsl:template match="d:variablelist/d:title"/>

  <!-- VariableList > Term -->
  <xsl:template match="d:varlistentry/d:term">
    <dt>
      <xsl:apply-templates/>
    </dt>
  </xsl:template>

  <!-- VariableList > VarListEntry -->
  <xsl:template match="d:varlistentry">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- VariableList > VarListEntry > ListItem -->
  <xsl:template match="d:varlistentry/d:listitem">
    <dd>
      <xsl:apply-templates/>
    </dd>
  </xsl:template>
</xsl:stylesheet>

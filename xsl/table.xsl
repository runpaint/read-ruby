<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <!-- Tables 
       A DocBook table is, effectively, identical to a HTML table, so we simply
       copy over the constituent elements verbatim. We deliberately ignore any
       attributes on these elements, so as to avoid interspersing layout
       information with content.
  -->

  <!-- InformalTable -->
  <xsl:template match="d:informaltable">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
  
  <!-- Table -->
  <xsl:template match="d:table">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
  
  <!-- Table > Caption -->
  <xsl:template match="d:table/d:caption">
    <caption>
      <xsl:apply-templates/>
    </caption>
  </xsl:template>

  <!-- Thead -->
  <xsl:template match="d:thead">
    <thead>
      <xsl:apply-templates/>
    </thead>
  </xsl:template>

  <!-- Tr -->
  <xsl:template match="d:tr">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <!-- Td -->
  <xsl:template match="d:td">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!-- Th -->
  <xsl:template match="d:th">
    <th>
      <xsl:apply-templates/>
    </th>
  </xsl:template>

  <!-- Tbody -->
  <xsl:template match="d:tbody">
    <tbody>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>

  <!-- Thead -->
  <xsl:template match="d:thead">
    <thead>
      <xsl:apply-templates/>
    </thead>
  </xsl:template>

  <!-- Tfoot -->
  <xsl:template match="d:tfoot">
    <tfoot>
      <xsl:apply-templates/>
    </tfoot>
  </xsl:template>
</xsl:stylesheet>

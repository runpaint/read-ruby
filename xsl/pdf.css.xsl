<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
		xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt d"
                version='1.0'>

  <xsl:template name="pdf.css">
    <xsl:text disable-output-escaping="yes">

/********** 
 *        *
 * FONTS  *
 *        *
 **********/

/* 

We use system fonts instead of the files in fonts/ because the former are of
better quality, and available in multiple styles.

* Bookletter 1911 is packaged as `ttf-goudybookletter`. The different styles
  appear to be inconsistently named, so we hardcode the filenames below.
* Linux Libertine is packaged as `ttf-linux-libertine` and named 'Linux Libertine O'.
* Inconsolata is packaged as `ttf-inconsolata`.
* unifont is packaged as `ttf-unifont`. It is used as a fallback for characters
  not represented by any of the above faces.
*/
  
@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911.ttf');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911Italic.ttf');
	font-weight: normal;
	font-style: italic;
}

@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/usr/share/fonts/truetype/goudybookletter/GoudyBookletter1911Bold.ttf');
	font-weight: bold;
	font-style: normal;
}

body {
  font-family: 'Linux Libertine O', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif, 'unifont';
  font-style: normal;
  font-size: large;
  font-color: black;
  background-color: transparent; 
}

code,
pre {
  font-family: 'Inconsolata', 'unifont', monospace;
  font-size: 90%;
}

h1,
h1 > code {
  font-family: 'Goudy Bookletter 1911', 'Linux Libertine O', Palatino, 
               'Palatino Linotype', 'Book Antiqua', Georgia, 'Times New Roman', 
               serif, 'unifont';
  font-weight: normal;
}

/*********** 
 *         *
 * LINKS   *
 *         *
 ***********/

article a:link, 
article a:visited, 
article a:hover, 
article a:active {
  text-decoration: none;
  border-bottom: 1px dotted;
  color: black;
}

sup > a:link, 
sup > a:visited, 
sup > a:hover, 
sup > a:active {
  text-decoration: none;
  border-bottom: none;
  font-weight: bold;
}

/************ 
 *          *
 * ARTICLES *
 *          *
 ************/

article {
  page-break-before: always;
}

@page {
    @top-center {
        content: 'Read Ruby 1.9 (DRAFT): http://ruby.runpaint.org/';
        font-weight: bold;
    }
    @bottom-left {
        content: '$git_date';
        font-size: small;
        font-style: italic;
    }
    @bottom-center {
        content: counter(page);
	font-style: italic;
    }
    background: url('../www/draft.png') no-repeat fixed center;
}

figcaption { display: none }

p {
  text-indent: 1em;
}

/*********** 
 *         *
 * HEADS   *
 *         *
 ***********/

/* masthead */
article > h1 {
  font-size: 500%;
  text-transform: uppercase;
  text-align: center;
  line-height: 80%;
  font-weight: bold;
  margin: 0;
  prince-bookmark-level: 1;
}

article > section > h1 {
  font-size: 200%;
  text-align: center;
  font-weight: normal;
  prince-bookmark-level: 2;
}

article > section > section > h1 {
  font-size: 150%;
  font-weight: normal;
  prince-bookmark-level: 3;
}

article > section > section > section > h1 {
  font-size: 130%;
  font-weight: normal;
  prince-bookmark-level: 4;
}

article > section > section > section > section > h1 {
  font-size: 130%;
  font-weight: normal;
  prince-bookmark-level: 5;
}

article > section > section > section > section > section > h1 {
  font-size: 130%;
  font-weight: normal;
  prince-bookmark-level: 6;
}

aside > h1 {
  prince-bookmark-level: none;
}

/*********** 
 *         *
 * TABLES  *
 *         *
 ***********/

table {
  margin-left: auto;
  margin-right: auto;
}

table thead {
  border-top: 1px solid black;
  border-bottom: 1px solid black;
}

/* All table cells are bordered with a thin black line */
table, 
table th,  
table tr, 
table td {
  border-collapse: collapse;
  padding-left: 5px;
  padding-right: 5px;
}

/* Table headings are bold and centered */
tbody > th, 
th {
  text-align: center
  display: inline;
  font-weight: bold;
}

/* The following two styles are for zebra striping table rows. The first is
 * cleaner, but assumes no rowspans; the second relies on a class being
 * applied manually to such tables. */

tbody tr:nth-child(2n+1) {
    background-color: #F5F5F5;
}

tbody > tr.odd {
    background-color: #F5F5F5;
}

/* Table captions are similar to figure captions. They are centered below the
 * table, in a slightly smaller, italic font */
table > caption {
  caption-side: bottom;
  margin-top: 2%;
  padding-top: 2%;
  text-align: center;
  font-style: italic;
  font-size: 90%;
}

/*********** 
 *         *
 * LISTS   *
 *         *
 ***********/

dl.inline dt {
  display: run-in;
  padding-right: 1em;
}

/* Display a list as a comma-separated list of elements */
ul.comma li {
  display: inline;
  list-style-type: none;
}

ul.comma li:after {
 content: ", ";
}

ul.comma li:before {
 content: " ";
}

ul.comma li:last-child:after {
  content: "";
}

ul.comma li:last-child:before {
  content: " and ";
}

ul.comma { 
  display: inline;
  list-style-type: none;
}

/************* 
 *           *
 * FOOTNOTES *
 *           *
 *************/

.fn {
  float: footnote;
  counter-increment: footnote;
}

article {
  counter-reset: footnote;
}

@page {
    @footnotes {
	border-top: solid black thin;
	padding-top: 8pt;
    }
}

/********** 
 *        *
 * COVER  *
 *        *
 **********/

@page:first { 
    @top { content: normal }
    @bottom-center { content: normal }
}

body > h1 {
  font-size: 1000%;
  text-transform: uppercase;
  text-align: center;
  line-height: 80%;
  font-weight: bold;
  margin: 0;
  padding-bottom: 5%;
}

body > p {
  text-align: center;
  font-size: 150%;
}

/************* 
 *           *
 *    ToC    *
 *           *
 *************/

.toc ol { 
  list-style-type: none; 
}

.toc a:link, 
.toc a:visited, 
.toc a:hover,
.toc a:active {
  text-decoration: none;
  border-bottom: none;
}

.toc a[href]::after {
  content: leader('.') target-counter(attr(href), page);
  font-variant: prince-opentype(tnum);
}

article.toc > ol > li > a { 
  font-weight: bold;
  font-size: 160%; 
}

article.toc > ol > li  { 
  margin-top: 3%;
}

article.toc > ol { 
  list-style-type: upper-roman; 
}

article.toc > ol > li > ol {
  margin-left: 3%;
}

article.toc > ol > li > ol > li { 
  list-style-type: none;
}

article.toc > ol > li > ol > li > a {
  font-size: 130%;
}

article.toc > ol > li > ol > li > ol {
  margin-left: 2%;
}

article.toc > ol > li > ol > li > ol > li { 
  list-style-type: none;
  font-size: 100%;
}

article.toc > ol > li > ol > li > ol > li > ol {
  margin-left: 2%;
}

article.toc > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: none;
  font-size: 100%;
}

article.toc > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: none;
  font-size: 100%;
}

article.toc > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: none; 
  font-size: 100%;
}

article.toc > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: none; 
  font-size: 100%;
}

.toc ol { 
  padding-left: 1%; 
  margin-left: 0;
}
    </xsl:text>    
  </xsl:template>
</xsl:stylesheet>

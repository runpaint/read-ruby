<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:template name="page.css">
    <xsl:text disable-output-escaping="yes">
/*********** 
 *         *
 *  LINKS  *
 *         *
 ***********/

/* Make in-book links less dominant*/

article a:link, 
article a:visited, 
article a:hover, 
article a:active {
  text-decoration: none;
  border-bottom: 1px dotted;
}

article a:link {
    color: black;
}

article a:visited {
  color: gray;
}

article a:visited {
  color: gray;
  border-bottom: none;
}

/* Permalinks */
.chapter h1 > a:link, 
.chapter h1 > a:visited, 
.chapter h1 > a:hover {
  font-size: 110%;
  color: #CCC;
  font-style: italic;
  font-weight: normal;
  border-bottom: none;
  text-decoration: none;
}

/* Hardcode quotation marks. The UA should do this, of course, but for some
   inexplicable reason, Chromium was messing up the opening mark. */   

q:before {
  content: '“';
}

q:after {
  content: '”';
}

/* We can’t use a simple class selector because it doesn’t have high-enough
 * specificity. !important is an option, of course...
 */
a[href^="#fn-"]:link, 
a[href^="#fn-"]:visited, 
a[href^="#fn-"]:hover, 
a[href^="#fn-"]:active {
  text-decoration: none;
  border-bottom: none;
  font-weight: bold;
}

/* The header is a strip that runs across the top of the screen and holds the
 * breadcrumb.
 */
body > header { 
  margin: 0; 
  padding: 0; 
  font-size: large;
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
}

/* The book name is hidden because it's repeated in the breadcrumb */
body > header > h1 {
  display: none;
}

/* The breadcrumb is marked up as a list, but we want it to display inline */
body > header li, body > header ol, body > header nav { display: inline; }

/* The breacrumb should be indented slightly from the left; flush with all
 * other margins.
 */
body > header > nav > ol {
  margin: 0;
  padding: 0 0 0 0.5em;
}

/* The crumbs should be separated by an arrow. */
body > header > nav > ol > li + li:before {
  content: " \2192 ";
}

/* The crumbs should be bold. */
body > header li {
  font-weight: bold;
}

/* The beta label following the chapter name in the breadcrumb should be red.
 */
body > header > nav > ol > li > span {
  color: red;
}

/* Search box */
body > header > nav > form {
  display:inline;
  margin-left: 1%;
}

/* The page content needs a top margin to separate it from the header. */
article {
  margin-top: 2em;
}

/* Article navigation, i.e. main sections */
article > header > nav > ol {
  padding: 0;
  margin-left: 8%;
  margin-right: 8%;
  width: auto;
  text-align: center;
}
article > header > nav > ol > li { 
  display: inline;
  padding: 0;
  margin: 0;
}

article > header > nav > ol > li:before { 
  content: "‣"; 
}

article > header > nav li:after { 
  content: "  "; 
}

/* Main article */
article > header > h1, 
body > section > h1 {
  font-size: 500%;
  text-transform: uppercase;
  text-align: center;
  line-height: 80%;
  margin: 0;
}
article > section > h1 {
  font-size: 200%;
  text-align: center;
}

article > section > section > h1 {
  font-size: 125%;
}

article > section > section > section > h1 {
  font-size: 110%;
  font-style: italic;
}

/* Glossary */

.glossary > section > h1 {
      text-align: left;
}

code {
  font-family: Inconsolata, 'Courier New', 'Courier', monospace;
  white-space: nowrap;
}
pre > code {
  white-space: pre;
  font-size: 80%;
}

samp {
  font-weight: bold;
}

kbd {
  font-style: italic;
}

h1.runin {
  font-size: 100%;
  font-weight: bold;
  display: run-in;
  padding-right: 0.5em;
  margin-right:0;
  margin-bottom:0;
  margin-left: 0;
}

figure {
  padding-left: 1em;
}

figure.railroad {
  margin-right: 0;
  margin-left: -12%;
  border: none;
}

figure > img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}

figcaption {
  display: none;
  font-size: small;
  font-style: italic;
}

figure.railroad > figcaption {
  text-align: center;
}

a.fn, 
a.returner {
  font-weight: bold;
}

ol.footnote-popup {
  position: absolute;
  width: 600px; 
}

li.footnote-container {
  position: relative;
  padding: 0.9em;
  margin-top: 1em;
  margin-bottom: 18px;
  background-color: #fff;
  border: 1px #cccccc solid; 
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

details {
  display: block;
}

details > * {
  display: none;
}

details.open > *, /* sigh :-( http://twitter.com/rem/status/2178972149 */
details[open] > * {
  display: block;
}

details > summary:first-child {
  display: block;
  cursor: pointer;
}

details[open] {
  display: block;
}

/* Make single-letter variables stand out */
/* Apply this automatically? */
var.l {
  font-weight: bold;
  font-size: 105%;
}

body > footer {
  text-align: center;
  font-style: italic;
  font-size: small;
}

body > footer:before {
  content: "\2767";
}
    </xsl:text>    
  </xsl:template>
</xsl:stylesheet>

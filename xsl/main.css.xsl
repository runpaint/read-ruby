<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:template name="main.css">
    <xsl:text disable-output-escaping="yes">
@font-face {
	font-family: 'Goudy Bookletter 1911';
	src: url('/fonts/eot/goudy_bookletter_1911-webfont');
	src: local('☺'), url('/fonts/woff/goudy_bookletter_1911-webfont') format('woff'), url('/fonts/ttf/goudy_bookletter_1911-webfont') format('truetype'), url('/fonts/svg/goudy_bookletter_1911-webfont#webfont') format('svg');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Inconsolata';
	src: url('/fonts/eot/Inconsolata-webfont');
	src: local('☺'), url('/fonts/woff/Inconsolata-webfont') format('woff'), url('/fonts/ttf/Inconsolata-webfont') format('truetype'), url('/fonts/svg/Inconsolata-webfont#webfont') format('svg');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'Linux Libertine';
	src: url('/fonts/eot/linlibertine_re-4.7.5-webfont');
	src: local('☺'), url('/fonts/woff/linlibertine_re-4.7.5-webfont') format('woff'), url('/fonts/ttf/linlibertine_re-4.7.5-webfont') format('truetype');
	font-weight: normal;
	font-style: normal;
}

body, kbd > span {
  font-family: 'Linux Libertine', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif;
}

body {
  font-style: normal;
  font-size: large;
  font-color: black;
  background-color: white; 
  margin-left: 12%;
  margin-right: 12%;
  /* TODO: Consider using off-white background colour like #FFFFF0. Would
   * require updating syntax diagrams.
   */
}

h1, 
h1 > code {
  font-family: 'Goudy Bookletter 1911', 'Linux Libertine', Palatino, 'Palatino Linotype', 
               'Book Antiqua', Georgia, 'Times New Roman', serif;
  font-style: bold;
  font-size: 100%;
}

figure, figcaption, aside, section, article, footer {
  display: block;
}
    </xsl:text>
  </xsl:template>
</xsl:stylesheet>

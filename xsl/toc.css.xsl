<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:template name="toc.css">
    <xsl:text>
article > ol > li > a { font-weight: bold }
ol { 
  list-style-type: circle; 
}
article > ol { 
  list-style-type: upper-roman; 
}
article > ol > li > ol > li { 
  list-style-type: upper-alpha;
}
article > ol > li > ol > li > ol > li { 
  list-style-type: decimal; 
}
article > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: lower-alpha;
}
article > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: square;
}
article > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: circle; 
}
article > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li > ol > li { 
  list-style-type: disc; 
}
ol { 
  padding-left: 3%; 
}
article {
  margin-top: 2em;
}
    </xsl:text>    
  </xsl:template>
</xsl:stylesheet>

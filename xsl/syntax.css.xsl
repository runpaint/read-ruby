<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:template name="syntax.css">
    <xsl:text disable-output-escaping="yes">
.hll { background-color: #ffffff }
.c { color: #8f5902; font-style: italic } /* Comment */
.g { color: #000000 } /* Generic */
.r, 
.kw { color: #204a87; font-weight: bold } /* Keyword */
.l { color: #000000 } /* Literal */
.n { color: #000000 } /* Name */
.o { color: #ce5c00; font-weight: bold } /* Operator USED? */
.x { color: #000000 } /* Other */
.p { color: #000000; font-weight: bold } /* Punctuation USED? */
.co { color: #204a87; font-weight: bold } /* Keyword.Constant */
.s { color: #4e9a06 } /* Literal.String */
.cl, 
.ps { color: #000000 } /* Name.Class */
.en { color: #ce5c00 } /* Name.Entity */
.ex { color: #cc0000; font-weight: bold } /* Name.Exception */
.fu { color: #000000 } /* Name.Function */
.la { color: #f57900 } /* Name.Label */
.ta { color: #204a87; font-weight: bold } /* Name.Tag */
.v { color: #000000 } /* Name.Variable */
.of { color: #204a87; font-weight: bold } /* Operator.Word */
.fl { color: #0000cf; font-weight: bold } /* Literal.Number.Float */
.hx { color: #0000cf; font-weight: bold } /* Literal.Number.Hex */
.i { color: #0000cf; font-weight: bold } /* Literal.Number.Integer */
.oc { color: #0000cf; font-weight: bold } /* Literal.Number.Oct */
.sh { color: #4e9a06 } /* Literal.String.Backtick */
.ch { color: #4e9a06 } /* Literal.String.Char */
.do { color: #8f5902; font-style: italic } /* Literal.String.Doc */
.sh { color: #4e9a06 } /* Literal.String.Heredoc */
.rx { color: #4e9a06 } /* Literal.String.Regex */
.sy { color: #4e9a06 } /* Literal.String.Symbol */
.cv { color: #000000 } /* Name.Variable.Class */
.gv { color: #000000 } /* Name.Variable.Global */
.iv { color: #000000 } /* Name.Variable.Instance */
    </xsl:text>
  </xsl:template>
</xsl:stylesheet>

<xsl:transform
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="2.0">

<xsl:output method="xml"/>
<xsl:output method="xhtml"/>
<xsl:template match="/" >
  <xsl:copy-of select="."/>
</xsl:template>

</xsl:transform>	

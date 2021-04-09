<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- default behavior -->
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:mode name="step2" on-no-match="shallow-copy"/>
    
    <!-- step1 -->
    <xsl:template match="variant"/>
    <xsl:template match="/">
        <xsl:variable name="step1">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$step1" mode="step2"/>
    </xsl:template>
    
    <!-- step2 -->
    <xsl:template mode="step2" match="token">
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:text>t_</xsl:text>
                <xsl:value-of select="count(preceding::line) + 1"/>
                <xsl:text>_</xsl:text>
                <xsl:value-of select="ancestor::line/descendant::token[. &lt;&lt; current()] => count() + 1"/>
            </xsl:attribute>
            <xsl:apply-templates mode="step2"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

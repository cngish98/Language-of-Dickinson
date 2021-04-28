<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- variables -->
    <xsl:variable name="bar-width" as="xs:integer" select="120"/>
    <xsl:variable name="spacing" as="xs:double" select="$bar-width div 2"/>
    <xsl:variable name="bars" as="xs:double" select="$bar-width + $spacing"/>
    <xsl:variable name="max-height" as="xs:integer" select="1"/>
    <xsl:variable name="y-scale" as="xs:integer" select="5000"/>
    <xsl:variable name="max-width" as="xs:double" select="4 * $bars"/>
    
    <xsl:template match="/">
        <svg viewBox="0 -300 700 400">
            <g>
                <!-- y-axis labels -->
                
                <!-- x-axis labels -->
<!--                <text x="{$max-width div 2}" y="70" text-anchor="middle" font-size="large">Type of Ellipsis</text>
                <text x="{$max-width div 2}" y="120" text-anchor="middle" font-size="x-large">Proportion of Instances of Ellipsis by Type to Number of Tokens</text>
                <!-\- ruling lines -\->
                <line x1="0" x2="{$max-width}" y1="-{$max-height * $y-scale div 2}" y2="-{$max-height * $y-scale div 2}" stroke-width="1" stroke="lightgray"/>
                <line x1="0" x2="{$max-width}" y1="-{$max-height * $y-scale}" y2="-{$max-height * $y-scale}" stroke-width="1" stroke="lightgray"/>
                <!-\- axes (y, then x) -\->
                <line x1="0" x2="{$max-width}" y1="0" y2="0" stroke="black" stroke-width="2" stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="{-$max-height * $y-scale}" stroke="black" stroke-width="2" stroke-linecap="square"/>-->
                <!-- apply-templates -->
                
                <!-- ellipsis variables-->
                <xsl:variable name="token-count" as="xs:integer" select="count(//token)"/>
                <xsl:variable name="nominal-count" as="xs:integer" select="count(//ellipsis[@ellipsis_type='nominal'])"/>
                <xsl:variable name="verbal-count" as="xs:integer" select="count(//ellipsis[@ellipsis_type='verbal'])"/>
                <xsl:variable name="clausal-count" as="xs:integer" select="count(//ellipsis[@ellipsis_type='clausal'])"/>
                <xsl:variable name="amb-count" as="xs:integer" select="count(//ellipsis[@ellipsis_type='ambiguous'])"/>
                
<!--                <xsl:variable name="nominal-prop" as="xs:double" select="$nominal-count div $token-count"/>
                <xsl:variable name="verbal-prop" as="xs:double" select="$verbal-count div $token-count"/>
                <xsl:variable name="clausal-prop" as="xs:double" select="$clausal-count div $token-count"/>
                <xsl:variable name="amb-prop" as="xs:double" select="$amb-count div $token-count"/>-->
                <xsl:variable name="data" as="element(data-element)+" xmlns="">
                    <data-element label="nominal" color="#A2A77F" value="{$nominal-count div $token-count}"/>
                    <data-element label="verbal" color="#002E2C" value="{$verbal-count div $token-count}"/>
                    <data-element label="clausal" color="#4F759B" value="{$clausal-count div $token-count}"/>
                    <data-element label="ambiguous" color="#542344" value="{$amb-count div $token-count}"/>
                </xsl:variable>
                
                <!-- bars -->
<!--                <rect x="{$bars}" width="{$bar-width}" y="-{$nominal-prop * $y-scale}" height="{$nominal-prop * $y-scale}" stroke="black" stroke-width="1.5" fill="blue"/>
                <rect x="{$bars * 2}" width="{$bar-width}" y="-{$verbal-prop * $y-scale}" height="{$verbal-prop * $y-scale}" stroke="black" stroke-width="1.5" fill="red"/>
                <rect x="{$bars * 3}" width="{$bar-width}" y="-{$clausal-prop * $y-scale}" height="{$clausal-prop * $y-scale}" stroke="black" stroke-width="1.5" fill="green"/>
                <rect x="{$bars * 4}" width="{$bar-width}" y="-{$amb-prop * $y-scale}" height="{$amb-prop * $y-scale}" stroke="black" stroke-width="1.5" fill="purple"/>-->
                
                <xsl:for-each select="$data">
                    <rect x="{(position() - 1) * $bars}" y="-{@value * $y-scale}" width="{$bar-width}" height="{@value * $y-scale}" stroke="black" stroke-width="1.5" fill="{@color}"/>
                    <text x="{(position() - 1) * $bars + $bar-width div 2}" y="20" text-anchor="middle" fill="{@color}">
                        <xsl:value-of select="@label"/>
                    </text>
                    <text x="{(position() - 1) * $bars + $bar-width div 2}" y="-{@value * $y-scale + 20}" text-anchor="middle" fill="{@color}">
                        <xsl:value-of select="format-number(@value, '0.000')"/>
                    </text>
                </xsl:for-each>
                
                <!-- bar labels -->
<!--                <text x="{$bars}" y="30" text-anchor="middle" font-size="small" fill="black">nominal</text>
                <text x="{$bars * 2}" y="30" text-anchor="middle" font-size="small" fill="black">verbal</text>
                <text x="{$bars * 3}" y="30" text-anchor="middle" font-size="small" fill="black">clausal</text>
                <text x="{$bars * 4}" y="30" text-anchor="middle" font-size="small" fill="black">amb</text>-->
            </g>
        </svg>
    </xsl:template>
    
 
</xsl:stylesheet>
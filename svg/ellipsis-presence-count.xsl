<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template name="xsl:initial-template">
        <svg height="800" width="1200">
            <g transform="translate(80,600)">
                <xsl:variable name="poems-corpus" as="document-node()+" select="collection('../tokenized-poems/?select=*.xml')"/>
                
                <xsl:variable name="bar-width" as="xs:integer" select="100"/>
                <xsl:variable name="spacing" as="xs:double" select="$bar-width div 2"/>
                <xsl:variable name="bars" as= "xs:double" select="$bar-width + $spacing"/>
                <xsl:variable name="max-width" as="xs:double" select="3 * $bars + 50"/>
                <xsl:variable name="max-height" as="xs:integer" select="90"/>
                <xsl:variable name="y-scale" as="xs:integer" select="5"/>
                
                <!-- ruling lines (from bottom (22.5) to top (90) -->
                <line x1="0" y1="-{$max-height * $y-scale div 4}" x2="{$max-width}" y2="-{$max-height * $y-scale div 4}" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="0" y1="-{$max-height * $y-scale div 2}" x2="{$max-width}" y2="-{$max-height * $y-scale div 2}" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="0" y1="-{$max-height * $y-scale * .75}" x2="{$max-width}" y2="-{$max-height * $y-scale * .75}" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="0" y1="-{$max-height * $y-scale}" x2="{$max-width}" y2="-{$max-height * $y-scale}" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                
                <!-- axes (x, then y) -->
                <line x1="0" x2="{$max-width}" y1="0" y2="0" stroke="black" stroke-width="2" stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="{-$max-height * $y-scale}" stroke="black" stroke-width="2" stroke-linecap="square"/>
                
                <!-- y-axis ruling line labels -->
                <text x="-15" y="0" text-anchor="middle">0</text>
                <text x="-15" y="-{$max-height * $y-scale div 2}" text-anchor="middle">45</text>
                <text x="-15" y="-{$max-height * $y-scale}" text-anchor="middle">90</text>
                
                <!-- y-axis label -->
                <text x="-50" y="-{$max-height * $y-scale div 2}" text-anchor="middle" writing-mode="tb" font-size="x-large">Total number of poems in our corpus</text>
                
                <!-- title (x-axis) -->
                <text x="{$max-width div 2}" y="60" text-anchor="middle" font-size="x-large">Ellipsis presence?</text>
                
                <xsl:for-each-group select="$poems-corpus//poem/metadata/ellipsis_present" group-by=".">
                    <xsl:sort order="descending"/>
                    
                    <xsl:variable name="ellipsis-count" select="count(current-group())"/>
                    
                    <xsl:variable name="type-pos" select="position()-1"/>
                    <xsl:variable name="x-pos" as="xs:double" select="$type-pos * $bars + $spacing"/>
                    <xsl:variable name="midbar-pos" as="xs:double" select="$x-pos + $bar-width div 2"/>
                    <xsl:variable name="bar_height" as="xs:double" select="count(current-group()) * $y-scale"/>
                    
                    <xsl:variable name="bar_color" as="xs:string" select="
                        if (current-grouping-key() = ('yes')) then
                        '#A2A77F'
                        else
                        if (current-grouping-key() = ('no')) then
                        '#4F759B'
                        else
                        '#945780'
                        "/>
                    <!-- bars (3) -->
                    <rect x="{$x-pos}" y="-{$ellipsis-count * $y-scale}" height="{$ellipsis-count * $y-scale}" width="{$bar-width}" 
                        stroke="black" stroke-width=".5" fill="{$bar_color}" />
                    
                    <!-- x-axis labels -->
                    <text x="{$midbar-pos}" y="30" text-anchor="middle" font-size="large">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>
                    
                    <!-- numerical labels (above each bar) -->
                    <text x="{$midbar-pos}" y="-{$bar_height + 10}" text-anchor="middle" fill="black"
                        font-size="medium">
                        <xsl:value-of select="count(current-group())"/>
                    </text>     
                </xsl:for-each-group>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
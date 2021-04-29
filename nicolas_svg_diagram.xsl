<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template name="xsl:initial-template">
        <svg height="800" width="1200">
            <g transform="translate(40,600)">
                <xsl:variable name="first_select" select="collection('./tokenized-poems/?select*.xml')"/>
                <line x1="30" y1="0" x2="300" y2="0" stroke="black" stroke-width="2"/>
                <line x1="30" y1="0" x2="30" y2="-270" stroke="black" stroke-width="2"/>
                <line x1="30" y1="-30" x2="300" y2="-30" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-60" x2="300" y2="-60" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-90" x2="300" y2="-90" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-120" x2="300" y2="-120" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-150" x2="300" y2="-150" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-180" x2="300" y2="-180" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-210" x2="300" y2="-210" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-240" x2="300" y2="-240" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <line x1="30" y1="-270" x2="300" y2="-270" stroke="grey" stroke-dasharray="4 4 4" stroke-width="2"></line>
                <text x="42" y="30">No</text>
                <text x="190" y="30">Yes</text>
                <text x="88" y="30">Ambiguous</text>
                <text x="-3" y="-27">10</text>
                <text x="-3" y="-57">20</text>
                <text x="-3" y="-87">30</text>
                <text x="-3" y="-117">40</text>
                <text x="-3" y="-147">50</text>
                <text x="-3" y="-177">60</text>
                <text x="-3" y="-207">70</text>
                <text x="-3" y="-237">80</text>
                <text x="-3" y="-267">90</text>
                <text x="-25" y="-135" text-anchor="middle" writing-mode="tb">Instances</text>
                <text x="150" y="60" text-anchor="middle">Ellipsis Present?</text>
                <!--<xsl:variable name="rectangle_1" select="distinct-values(//poem/metadata/ellipsis_present)"></xsl:variable>-->
                <xsl:for-each-group select="$first_select//poem/metadata/ellipsis_present" group-by=".">
                <xsl:variable name="equation" select="count(current-group())"></xsl:variable>
                    <xsl:variable name="position_2" select="50"/>
                    <xsl:variable name="spacing" select="25"/>
                    <xsl:variable name="position" select="((position()-1)*($position_2+$spacing)+30)"/>
                    
                    
                
                
                <rect x="{$position}" y="{-$equation*3}" height="{$equation*3}" width="50"></rect>
                    
                </xsl:for-each-group>
                
            </g>
        </svg>
    </xsl:template>
       
    
    
</xsl:stylesheet>

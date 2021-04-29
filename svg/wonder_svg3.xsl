<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!--===============================Variables==============================================-->
    <xsl:variable name="poems_corpus"
        select="collection('../tokenized-poems/?select=*.xml')"/>
    <xsl:variable name="poem_themes" select="distinct-values($poems_corpus//poem_themes/theme)"/>
    <xsl:variable name="bar_width" select="25" as="xs:double"/>
    <xsl:variable name="bar_spacing" select="$bar_width div 2" as="xs:double"/>
    <xsl:variable name="left_bar_spacing" select="$bar_width + $bar_spacing" as="xs:double"/>
    <xsl:variable name="y_scaling" select="10" as="xs:double"/>
    <!-- ===================================================================================== -->
    
    <xsl:template name="xsl:initial-template">
        <svg viewBox="-100 -500 {count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing) + 150} 600" width="100%">
            <g>
                
                <!--Guiding lines-->
                <line x1="0" x2="{count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)}"
                    y1="-225" y2="-225" stroke="lightgray"
                    stroke-dasharray="8 4" stroke-width="1"/>
                
                
                <!--Generates bars for the poems-->
                <xsl:for-each-group select="$poems_corpus//theme" group-by=".">
                    <xsl:sort data-type="text"/>
                    <xsl:variable name="poem_position" select="position() - 1" as="xs:integer"/>
                    <xsl:variable name="x_position" select="$poem_position * ($bar_spacing + $left_bar_spacing)"
                        as="xs:double"/>
                    <xsl:variable name="mid_bar_position" as="xs:double" select="($x_position + $bar_width) div 2"/>
                    <xsl:variable name="bar_height" as="xs:double" select="count(current-group()) * $y_scaling"/>
                    <xsl:variable name="bar_color" as="xs:string" select="
                        if (current-grouping-key() = ('nature' , 'animal')) then
                        '#1B998B'
                        else
                        if (current-grouping-key() = ('emotion' , 'love' , 'loss' , 'mind' , 'uncertainty' , 'solitude')) then
                        '#BBA2CD'
                        else
                        if (current-grouping-key() = ('religion' , 'supernatural')) then
                        '#266DD3'
                        else
                        if (current-grouping-key() = ('childhood' , 'memory' , 'time')) then
                        '#A72608'
                        else
                        if (current-grouping-key() = ('writing' , 'science' , 'music' , 'law')) then
                        '#c97f14'
                        else
                        if (current-grouping-key() = ('the body' , 'eating' , 'violence')) then
                        '#FD216E'
                        else
                        if (current-grouping-key() = ('social norms' , 'social class' , 'wealth' , 'war' , 'labor')) then
                        '#FD216E'
                        else
                        if (current-grouping-key() = ('relationships')) then
                        '#D88C9A'
                        else
                        '7F2CCB'
                        "/>
                    
                    
                    <rect x="{$x_position}" y="-{$bar_height}" stroke="black" stroke-width=".5" fill="{$bar_color}"
                        width="{$bar_width}" height="{$bar_height}"/>
                    
                    <!--Labels for the poems-->
                    <text x="{$x_position + $bar_width div 2}" y="20" text-anchor="middle"
                        font-size="68%">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>
                    
                    <!--Labels for numerical values
                    <text x="{$mid_bar_position}" y="-{$bar_height + 5}" text-anchor="middle" fill="black"
                        font-size="small">
                        <xsl:value-of select="count(current-group())"/>
                    </text>  -->
                </xsl:for-each-group>
                
                <!-- X and Y axes -->
                <xsl:variable name="x_axis_length" as="xs:double"
                    select="count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)"/>
                <line x1="0" x2="{$x_axis_length}" y1="0" y2="0" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="-450" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                
                <!--Interval labels-->
                <text x="-5" y="0" text-anchor="end" dominant-baseline="middle">0</text>
                <text x="-5" y="-225" text-anchor="end" dominant-baseline="middle"
                    >45</text>
                <text x="-5" y="-450" text-anchor="end" dominant-baseline="middle">90</text>
                
                <!-- Other labels -->
                <text x="{$x_axis_length div 2}" y="50" text-anchor="middle" font-size="x-large"
                    >Poem themes</text>
                <text x="-50" y="-225" text-anchor="middle" writing-mode="tb"
                    font-size="x-large">Times appeared in all 90 poems</text>
                <text x="{$x_axis_length div 2}" y="90" text-anchor="middle" font-size="xx-large"
                    >Total amount of themes across Emily Dickinson's poems</text>
            </g>
        </svg>
    </xsl:template>
    
    <xsl:template match="theme">
        <!--Variables-->
        <xsl:variable name="poem_position" select="position() - 1" as="xs:integer"/>
        <xsl:variable name="x_position" select="$poem_position * $bar_spacing + $left_bar_spacing"
            as="xs:double"/>
        <xsl:variable name="mid_bar_position" as="xs:double" select="($x_position + $bar_width) div 2"/>
        <xsl:variable name="bar_color" as="xs:string" select="
            if ($poem_themes eq 'nature' or 'animal') then
            '#1B998B'
            else
            if ($poem_themes eq 'emotion' or 'love' or 'loss' or 'mind' or 'solitude' or 'uncertainty') then
            '#BBA2CD'
            else
            if ($poem_themes eq 'religion' or 'supernatural') then
            '#266DD3'
            else
            if ($poem_themes eq 'childhood' or 'memory' or 'time') then
            '#A72608'
            else
            if ($poem_themes eq 'writing' or 'science' or 'music' or 'law') then
            '#c97f14'
            else
            if ($poem_themes eq 'eating' or 'the body' or 'violence') then
            '#FD216E'
            else
            if ($poem_themes eq 'social norms' or 'social class' or 'war' or 'wealth' or 'labor') then
            '#ECBB83'
            else
            if ($poem_themes eq 'relationships') then
            '#D88C9A'
            else
            '#7F2CCB'
            "/>
        <xsl:variable name="total_themes" as="xs:double" select="count($poem_themes)"/>
        <xsl:variable name="bar_height" as="xs:double" select="$total_themes * $y_scaling"/>
        
        
        <rect x="{$x_position}" y="-{$bar_height}" stroke="black" stroke-width=".5" fill="{$bar_color}"
            width="{$bar_width}" height="{$bar_height}"/>
        <text x="{$x_position + $bar_width div 2}" y="10" text-anchor="start" writing-mode="tb"> 
            <xsl:value-of select="$poem_themes"/>
        </text>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

    <xsl:output method="xml" indent="yes"/>

    <!--===============================Variables==============================================-->
    <xsl:variable name="poems_corpus" select="collection('../tokenized-poems/?select=*.xml')"/>
    <xsl:variable name="poem_themes" select="distinct-values($poems_corpus//poem_themes/theme)"/>
    <xsl:variable name="bar_width" select="28" as="xs:double"/>
    <xsl:variable name="bar_spacing" select="$bar_width div 2" as="xs:double"/>
    <xsl:variable name="left_bar_spacing" select="$bar_width + $bar_spacing" as="xs:double"/>
    <!--    <xsl:variable name="max-width" select="28 * ($bar_width + $bar_spacing)+ 50"/>-->
    <xsl:variable name="y_scaling" select="10" as="xs:double"/>
    <xsl:variable name="max-height" select="48" as="xs:integer"/>
    <!-- ===================================================================================== -->

    <xsl:template name="xsl:initial-template">
        <svg
            viewBox="-100 -500 1718 600"
            width="100%">
            <g>

                <!--Guiding lines-->
                <line x1="0"
                    x2="{count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)}"
                    y1="-{$max-height div 2 * $y_scaling}" y2="-{$max-height div 2 * $y_scaling}"
                    stroke="lightgray" stroke-dasharray="8 4" stroke-width="1"/>
                <line x1="0"
                    x2="{count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)}"
                    y1="-{$max-height div 4 * $y_scaling}" y2="-{$max-height div 4 * $y_scaling}"
                    stroke="lightgray" stroke-dasharray="8 4" stroke-width="1"/>
                <line x1="0"
                    x2="{count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)}"
                    y1="-{$max-height * .75 * $y_scaling}" y2="-{$max-height * .75 * $y_scaling}"
                    stroke="lightgray" stroke-dasharray="8 4" stroke-width="1"/>


                <!--Generates bars for the poems-->
                <xsl:for-each-group select="$poems_corpus//theme" group-by=".">
                    <xsl:sort data-type="text"/>
                    <xsl:variable name="poem_position" select="position() - 1" as="xs:integer"/>
                    <xsl:variable name="x_position"
                        select="$poem_position * ($bar_spacing + $left_bar_spacing) + $bar_spacing"
                        as="xs:double"/>
                    <xsl:variable name="mid_bar_position" as="xs:double"
                        select="$x_position + $bar_width div 2"/>
                    <xsl:variable name="bar_height" as="xs:double"
                        select="count(current-group()) * $y_scaling"/>
                    <xsl:variable name="bar_color" as="xs:string" select="
                            if (current-grouping-key() = ('nature', 'animal')) then
                                '#1B998B'
                            else
                                if (current-grouping-key() = ('emotion', 'love', 'loss', 'the mind', 'uncertainty', 'solitude')) then
                                    '#BBA2CD'
                                else
                                    if (current-grouping-key() = ('religion', 'supernatural')) then
                                        '#266DD3'
                                    else
                                        if (current-grouping-key() = ('childhood', 'memory', 'time')) then
                                            '#A72608'
                                        else
                                            if (current-grouping-key() = ('writing', 'science', 'music', 'law')) then
                                                '#c97f14'
                                            else
                                                if (current-grouping-key() = ('the body', 'eating', 'violence')) then
                                                    '#FD216E'
                                                else
                                                    if (current-grouping-key() = ('social norms', 'social class', 'wealth', 'war', 'labor')) then
                                                        '#FD216E'
                                                    else
                                                        if (current-grouping-key() = ('relationships')) then
                                                            '#D88C9A'
                                                        else
                                                            '#7F2CCB'
                            "/>


                    <rect x="{$x_position}" y="-{$bar_height}" stroke="black" stroke-width=".5"
                        fill="{$bar_color}" width="{$bar_width}" height="{$bar_height}"/>

                    <!-- theme labels for the poems-->
                    <text x="{$x_position + $bar_width div 2}" y="20" text-anchor="start"
                        font-size="medium" transform="rotate(25, {$mid_bar_position}, 10)">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>

                    <!--  Labels for numerical values-->
                    <text x="{$mid_bar_position}" y="-{$bar_height + 5}" text-anchor="middle"
                        fill="black" font-size="small">
                        <xsl:value-of select="count(current-group())"/>
                    </text>
                </xsl:for-each-group>

                <!-- X and Y axes -->
                <xsl:variable name="x_axis_length" as="xs:double"
                    select="count($poems_corpus//theme => distinct-values()) * ($bar_spacing + $left_bar_spacing)"/>
                <line x1="0" x2="{$x_axis_length}" y1="0" y2="0" stroke="black" stroke-width="1"
                    stroke-linecap="square"/>
                <line x1="0" x2="0" y1="0" y2="-{$max-height * $y_scaling}" stroke="black"
                    stroke-width="1" stroke-linecap="square"/>

                <!--Interval labels-->
                <text x="-5" y="0" text-anchor="end" dominant-baseline="middle">0</text>
                <text x="-5" y="-{$max-height div 2 * $y_scaling}" text-anchor="end"
                    dominant-baseline="middle">24</text>
                <text x="-5" y="-{$max-height * $y_scaling}" text-anchor="end"
                    dominant-baseline="middle">48</text>
                <text x="-5" y="-{$max-height div 4 * $y_scaling}" text-anchor="end"
                    dominant-baseline="middle">12</text>
                <text x="-5" y="-{$max-height * .75 * $y_scaling}" text-anchor="end"
                    dominant-baseline="middle">36</text>

                <!-- Other labels -->
                <text x="{$x_axis_length div 2}" y="100" text-anchor="middle" font-size="x-large"
                    >Poem theme</text>
                <text x="-50" y="-225" text-anchor="middle" writing-mode="tb" font-size="x-large"
                    >Number of poems containing theme</text>
                <!--<text x="{$x_axis_length div 2}" y="150" text-anchor="middle" font-size="xx-large"
                    >Number of Poems Containing a Particular Theme (by Theme)</text>-->
            </g>
        </svg>
    </xsl:template>

    <!--DUPLICATE TEMPLATE-->
    <xsl:template match="theme">
        <!--Variables-->
        <xsl:variable name="poem_position" select="position() - 1" as="xs:integer"/>
        <xsl:variable name="x_position" select="$poem_position * $bar_spacing + $left_bar_spacing"
            as="xs:double"/>
        <xsl:variable name="mid_bar_position" as="xs:double"
            select="($x_position + $bar_width) div 2"/>
        <xsl:variable name="bar_color" as="xs:string" select="
                if ($poem_themes eq 'nature' or 'animal') then
                    '#1B998B'
                else
                    if ($poem_themes eq 'emotion' or 'love' or 'loss' or 'the mind' or 'solitude' or 'uncertainty') then
                        '#BBA2CD'
                    else
                        if ($poem_themes eq 'religion' or 'supernatural') then
                            '#266DD3'
                        else
                            if ($poem_themes eq 'childhood' or 'memory' or 'time') then
                                '#A72608'
                            else
                                if ($poem_themes eq 'writing' or 'music' or 'law') then
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


        <rect x="{$x_position}" y="-{$bar_height}" stroke="black" stroke-width=".5"
            fill="{$bar_color}" width="{$bar_width}" height="{$bar_height}"/>
        <text x="{$x_position + $bar_width div 2}" y="10" text-anchor="start" writing-mode="tb">
            <xsl:value-of select="$poem_themes"/>
        </text>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <!-- ========================================================== -->
    <!-- Wraps <token> tags around all whitespace-separated word    -->
    <!--   tokens in text() nodes in the body of the poem           -->
    <!-- Adds unique @xml:id identifiers                            --> 
    <!--   t_line-number_token-number-in-line                       -->
    <!--                                                            -->
    <!-- TODO (maybe): Punctuation is tokenized inconsistently,     -->
    <!--   sometimes separately, sometimes as part of word          -->
    <!-- ========================================================== -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:strip-space elements="line"/>
    <xsl:template match="line//text()">
        <xsl:variable name="line-number" as="xs:integer"
            select="ancestor::line ! count(preceding::line) + 1"/>
        <!--
            All preceding text() nodes in same line            
        -->
        <xsl:variable name="preceding-token-count" as="xs:integer" select="
                preceding::text()[ancestor::line is current()/ancestor::line] !
                normalize-space(.) =>
                string-join(' ') =>
                tokenize('\s+') =>
                count()"/>
        <xsl:variable name="tokenized-text" as="xs:string+"
            select="normalize-space(.) => tokenize()"/>
        <xsl:for-each select="$tokenized-text">
            <token>
                <xsl:attribute name="xml:id" select="
                        't_' || $line-number
                        || '_' || $preceding-token-count + position()"/>
                <xsl:value-of select="."/>
            </token>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

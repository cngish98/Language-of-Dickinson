<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    
    <xsl:variable name="poems_corpus"
        select="collection('tokenized-poems/?select=*.xml')"/>

    <!-- first draft of what we could potentially do for the reading view
        definitely needs revisiting
    -->

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="reading_view-1.css"/>
                <title>Dickinson Poems</title>
            </head>
            <body>
                <div class='sidebar-box'>
                    <h5>Tags: ellipsis</h5>
                    <div class='sidebar-selecting-container'>
                        <input type="checkbox" id="nominal" name="nominal"/>
                            <label for="nominal">Nominal</label><br/>
                        <input type="checkbox" id="verbal" name="verbal"/>
                        <label for="verbal">Verbal</label><br/>
                        <input type="checkbox" id="clausal" name="clausal"/>
                        <label for="clausal">Clausal</label><br/>
                        <input type="checkbox" id="ambiguous" name="ambiguous"/>
                        <label for="ambiguous">Ambiguous</label>
                    
                    </div>
                </div>
               <div class="text-box">
                   <!-- <xsl:apply-templates select="$poems_corpus//metadata"/>
                   <xsl:apply-templates select="$poems_corpus//body"/> -->
               </div>
            </body>
        </html>
    </xsl:template>

<!-- METADATA -->
    <xsl:template match="metadata">
        <h1>
            <xsl:text>"</xsl:text>
            <xsl:apply-templates select="first_line"/>
            <xsl:text>"</xsl:text>
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="poem_number"/>
            <xsl:text>)</xsl:text>
        </h1>
        <h2>
            <xsl:apply-templates select="date"/>
            <xsl:text> - </xsl:text>
            <xsl:apply-templates select="date/@period"/>
            <xsl:text> period</xsl:text>
        </h2>
        <h3>
            <xsl:text>themes: </xsl:text>
            <xsl:apply-templates select="poem_themes"/>
        </h3>
    </xsl:template>
 
 <!-- BODY -->
    <xsl:template match="stanza">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="line">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::line">
            <br/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ellipsis">
        <xsl:text>[</xsl:text>
        <span class="{@ellipsis_type}">
            <xsl:apply-templates/>
            <xsl:apply-templates select="@possible_string"/>
        </span>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    <xsl:template match="variant | character | emotion 
        | animal | place | nature | love | death | life | memory | childhood | 
        time | social_norm | war | religion | writing | science | music | 
        law | mind | physical_body | eating | solitude | supernatural | violence | 
        wealth | labor | social_class | light | darkness | uncertainty | loss">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>

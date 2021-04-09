<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs" version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    
    
    <xsl:variable name="poems_corpus" select="collection('Language-of-Dickinson/word-tokenized/?select=*.xml')"/>
    <!-- <xsl:apply-templates select="$poems_corpus//body"/> -->
    
    
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Sonnets</title>
                <link rel="stylesheet" type="text/css" href="wonder-xslt6.css"/>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css?family=Open+Sans%7CBitter"/>
            </head>
            
            <body>
                <h1>Dickinson's Poems</h1>
                <h2>Search for poems here</h2>
                <table> 
                    <tr>
                        <th>First line / title</th>
                        <th>Date</th>
                        <th>Recipient?</th>
                        <th>Ellipsis present?</th>
                        <th>Themes</th>
                    </tr>
                    
                    <xsl:apply-templates select="$poems_corpus//metadata"/>
                </table>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="metadata">
        <tr>
            <td>
                <xsl:apply-templates select="first_line"/>
            </td>
            <td>
                <xsl:apply-templates select="date"/>
            </td>
            <td>
                <xsl:apply-templates select="recipient"/>
            </td>
            <td>
                <xsl:apply-templates select="ellipsis_present"/>
            </td>
            <td>
                <xsl:apply-templates select="poem_themes"/>
            </td>
        </tr>
    </xsl:template> 
    
</xsl:stylesheet>
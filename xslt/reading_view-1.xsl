<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    
    <xsl:variable name="poems_corpus" as="document-node()+"
        select="collection('../tokenized-poems/?select=*.xml')"/>
    
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Emily Dickinson &amp; Ellipsis</title>
                <link rel="stylesheet" type="text/css" href="reading_view-1.css"/>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Bitter%7COpen+Sans" />
                <link rel="shortcut icon" type="image/jpeg" href="dickinson-portrait.jpeg"/>
            </head>
            <body>
                
                
                <div class="heading-container">
                    <img src="dickinson-portrait.jpeg" id="portrait" alt="portrait of Emily Dickinson"/>
                    <h1>EMILY DICKINSON &amp; ELLIPSIS</h1>
                    <h2>a digital humanities project</h2>
                </div>
                
                <div class='menu-container'>
                    <div class='menu'>
                        <a href='index.xhtml'>home</a>
                        
                        <a href='about.xhtml'>about</a>
                        
                        <a href='corpus.xhtml'>corpus</a>
                        
                        <a href='methods.xhtml'>methods</a>
                        
                        <a href='results.xhtml'>results</a>
                    </div>
                </div>
                
                <div class='sidebar-box'>
                    <!--Ideally should be hidden when the viewer is only 
                    looking at the table -->
                    <h2 class="sidebar-header">I want to highlight:</h2>
           
                    <div class='sidebar-selecting-container'>
                        <h3 class="sidebar-header">Ellipsis</h3>
                        <input type="checkbox" id="nominal" name="nominal"/>
                            <label for="nominal">Nominal</label><br/>
                        <input type="checkbox" id="verbal" name="verbal"/>
                        <label for="verbal">Verbal</label><br/>
                        <input type="checkbox" id="clausal" name="clausal"/>
                        <label for="clausal">Clausal</label><br/>
                        <input type="checkbox" id="ambiguous" name="ambiguous"/>
                        <label for="ambiguous">Ambiguous</label>
                    </div>
                    
                    <div class='sidebar-selecting-container'>
                        <h3 class="sidebar-header">Theme</h3>
                        <input type="checkbox" id="nature" name="nature"/>
                        <label for="nature">Nature</label><br/>
                        <input type="checkbox" id="religion" name="religion"/>
                        <label for="religion">Religion</label><br/>
                        <input type="checkbox" id="writing" name="writing"/>
                        <label for="writing">Writing</label><br/>
                    </div>
                </div>
                
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
                    
                    <xsl:apply-templates select="$poems_corpus//metadata" mode="table"/>
                </table>
                
               <div class="text-box">
                   <xsl:apply-templates select="$poems_corpus"/>
               </div>
            </body>
        </html>
    </xsl:template>

<!-- METADATA -->
    
    <xsl:template match="metadata" mode="table">
        <tr>
            <td>
                <a href="#poem{first_line}"><xsl:apply-templates select="first_line"/>
                </a>
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
    
    <xsl:template match="metadata">
        <h1 id="poem{first_line}">
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
            <xsl:text>themes: </xsl:text>       <!-- how do we want these to be shown / separated on the site? -->
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
    
    <!-- inserts a [...] for every instance of ellipsis -->
    <xsl:template match="ellipsis">
        <xsl:text>[...</xsl:text>
        <span class="{@ellipsis_type}">
            <xsl:apply-templates/>
        </span>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
<!--    <!-\- inserts possible string into [ ] for every instance of ellipsis -\-> <!-\- Q: what happens, then, when there is no possible string? -\->
    <xsl:template match="ellipsis">
        <xsl:text>[</xsl:text>
        <span class="{@ellipsis_type}">
            <xsl:apply-templates/>
            <xsl:apply-templates select="@possible_string"/>
        </span>
        <xsl:text>]</xsl:text>
    </xsl:template>-->
    
    <xsl:template match="character | emotion 
        | animal | place | nature | love | death | life | memory | childhood | 
        time | social_norm | war | religion | writing | science | music | 
        law | mind | physical_body | eating | solitude | supernatural | violence | 
        wealth | labor | social_class | light | darkness | uncertainty | loss">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>

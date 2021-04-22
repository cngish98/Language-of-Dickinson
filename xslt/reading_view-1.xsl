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
                <script src="show-hide-table.js"/>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css?family=Bitter%7COpen+Sans"/>
                <link rel="shortcut icon" type="image/jpeg" href="dickinson-portrait.jpeg"/>
            </head>
            <body>

<!--=====================Website header and menu=================================-->
                <div class="heading-container">
                    <img src="dickinson-portrait.jpeg" id="portrait"
                        alt="portrait of Emily Dickinson"/>
                    <h1 id="main-header-1">EMILY DICKINSON &amp; ELLIPSIS</h1>
                    <h2 id="main-header-2">a digital humanities project</h2>
                </div>

                <div class="menu-container">
                    <div class="menu">
                        <a href="index.xhtml">home</a>

                        <a href="about.xhtml">about</a>

                        <a href="corpus.xhtml">corpus</a>

                        <a href="methods.xhtml">methods</a>

                        <a href="results.xhtml">results</a>
                    </div>
                </div>
                
<!--==================Checkboxes for filtering poems=================================-->
                <h1>Dickinson's Poems</h1>
                <div class="poems-filtering-box">
                    <h2 class="sidebar-header">I want to view poems by:</h2>
                    
                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Time period written</h3>
                        <input type="checkbox" id="early" name="early"/>
                        <label for="early">Early (1850-1862)</label>
                        <br/>
                        <input type="checkbox" id="middle" name="middle"/>
                        <label for="middle">Middle (1863-1874)</label>
                        <br/>
                        <input type="checkbox" id="late" name="late"/>
                        <label for="late">Late (1875-1886)</label>
                        <br/>
                    </div>
                    
                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Recipient / no recipient</h3>
                        <input type="checkbox" id="yes-recipient" name="yes-recipient"/>
                        <label for="yes-recipient">Yes</label>
                        <br/>
                        <input type="checkbox" id="no-recipient" name="no-recipient"/>
                        <label for="no-recipient">No</label>
                        <br/>
                    </div>
                    
                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Ellipsis / no ellipsis</h3>
                        <input type="checkbox" id="yes-ellipsis" name="yes-ellipsis"/>
                        <label for="yes-ellipsis">Yes</label>
                        <br/>
                        <input type="checkbox" id="no-ellipsis" name="no-ellipsis"/>
                        <label for="no-ellipsis">No</label>
                        <br/>
                        <input type="checkbox" id="ambiguous-ellipsis" name="ambiguous-ellipsis"/>
                        <label for="ambiguous-ellipsis">Ambiguous</label>
                        <br/>
                    </div>
                </div>

<!--=====================Table of contents=============================================-->
               <div class="show-hide-table">
                <button onclick="showDropdown()" class="dropdownButton">Not sure where to start? Click here to search!</button>
                <h2 class="below-button">(Click again to hide)</h2>
                <table id="dropdownTable" class="dropdownContent">
                    <tr>
                        <th>First line / title</th>
                        <th>Date</th>
                        <th>Recipient?</th>
                        <th>Ellipsis present?</th>
                        <th>Themes</th>
                    </tr>

                    <xsl:apply-templates select="$poems_corpus//metadata" mode="table"/>
                </table>
               </div>
                
                <!--=====================Sidebar: checkboxes for adding color to attributes=================================-->

                <div class="sidebar-box">
                    <!--Ideally should be hidden when the viewer is only 
                    looking at the table -->
                    <h2 class="sidebar-header">I want to highlight:</h2>
                    
                    <div class="sidebar-selecting-container">
                        <h3 class="sidebar-header">Ellipsis</h3>
                        
                        <input type="checkbox" id="nominal" name="nominal"/>
                        <label for="nominal">Nominal</label>
                        <br/>
                        <input type="checkbox" id="verbal" name="verbal"/>
                        <label for="verbal">Verbal</label>
                        <br/>
                        <input type="checkbox" id="clausal" name="clausal"/>
                        <label for="clausal">Clausal</label>
                        <br/>
                        <input type="checkbox" id="ambiguous" name="ambiguous"/>
                        <label for="ambiguous">Ambiguous</label>
                    </div>
                    
                    <div class="sidebar-selecting-container">
                        <h3 class="sidebar-header">Theme</h3>
                        
                        <input type="checkbox" id="body" name="body"/>
                        <label for="body"><strong style="color:red;">The body and related concepts</strong> (eating, violence)</label>
                        <br/>
                        <input type="checkbox" id="disciplines" name="disciplines"/>
                        <label for="disciplines"><strong style="color:#f08d0c;">Disciplines</strong> (law, music, science, writing)</label>
                        <br/>
                        <input type="checkbox" id="emotion" name="emotion"/>
                        <label for="emotion"><strong style="color:purple;">Emotions / state of mind</strong> (emotions, loss, love, the mind, solitude, uncertainty)</label>
                        <br/>
                        <input type="checkbox" id="nature" name="nature"/>
                        <label for="nature"><strong style="color:green;">Nature and animals</strong></label>
                        <br/>
                        <input type="checkbox" id="relationships" name="relationships"/>
                        <label for="relationships"><strong style="color:#d56cd9;">Interpersonal relationships</strong> (characters and reference to people)</label>
                        <br/>
                        <input type="checkbox" id="religion" name="religion"/>
                        <label for="religion"><strong style="color:#2a5fa3;">Religion and the supernatural</strong></label>
                        <br/>
                        <input type="checkbox" id="social" name="social"/>
                        <label for="social"><strong style="color:#b09012;">Social constructs and allusions</strong> (social norms, social class, war, wealth, labor)</label>
                        <br/>
                        <input type="checkbox" id="time" name="time"/>
                        <label for="time"><strong style="color:#9b93bd;">Time-based experiences</strong> (childhood, memory, time)</label>
                        <br/>
                        <input type="checkbox" id="abstract" name="abstract"/>
                        <label for="abstract"><strong style="color:#88cf9f;">Other abstract concepts</strong> (life, death, light, darkness)</label>
                        <br/>
                    </div>
                </div>
                
               <!--Display the poems -->
                
                <div class="text-box">
                    <xsl:apply-templates select="$poems_corpus"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- METADATA FOR TABLE -->

    <xsl:template match="metadata" mode="table">
        <tr>
            <td>
                <a href="#poem{translate(//first_line, ' ', '-')}">
                    <xsl:apply-templates select="first_line"/>
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
                <xsl:apply-templates select="string-join(poem_themes//theme, ', ')"/>
            </td>
        </tr>
    </xsl:template>
    <!--=====================POEMS DISPLAY=============================================-->
    <xsl:template match="metadata">
        <h1 id="poem{translate(//first_line, ' ', '-')}">
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
            <xsl:text>Recipient(s): </xsl:text>
            <xsl:apply-templates select="recipient"/>
        </h3>
        <h3>
            <xsl:text>themes: </xsl:text>
            <xsl:apply-templates select="string-join(poem_themes//theme, ', ')"/>
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
        <span class="tooltip">[...]
        <span class="tooltiptext">
            <xsl:apply-templates/>
            <xsl:apply-templates select="@possible_string"/>
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="@ellipsis_type"/>
            <xsl:text>)</xsl:text>
        </span>
        </span>
    </xsl:template>
    
    <!--<span class="{@ellipsis_type}">
        <xsl:apply-templates/>
        <xsl:apply-templates select="@possible_string"/>
    </span>
    </p>-->

    <!--    <!-\- inserts possible string into [ ] for every instance of ellipsis -\-> <!-\- Q: what happens, then, when there is no possible string? -\->
    <xsl:template match="ellipsis">
        <xsl:text>[</xsl:text>
        <span class="{@ellipsis_type}">
            <xsl:apply-templates/>
            <xsl:apply-templates select="@possible_string"/>
        </span>
        <xsl:text>]</xsl:text>
    </xsl:template>-->

    <xsl:template match="
            character | emotion
            | animal | place | nature | love | death | life | memory | childhood |
            time | social_norm | war | religion | writing | science | music |
            law | mind | physical_body | eating | solitude | supernatural | violence |
            wealth | labor | social_class | light | darkness | uncertainty | loss">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>

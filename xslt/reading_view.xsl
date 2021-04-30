<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!-- ================================================================ -->
    <!-- Stylesheet variables                                             -->
    <!--                                                                  -->
    <!-- $poems_corpus : collection of XML documents, one per poem        -->
    <!-- $metatheme-by-theme : map from 31 inline themes to 9 checkboxes  -->
    <!-- ================================================================ -->
    <xsl:variable name="poems_corpus" as="document-node()+"
        select="collection('../tokenized-poems/?select=*.xml')"/>
    <xsl:variable name="metatheme-by-theme" as="map(*)">
        <!-- ============================================================ -->
        <!-- Map the 31 inline theme elements to the 9 meta-themes        -->
        <!-- supported by the checkboxes in the interface                 -->
        <!-- ============================================================ -->
        <xsl:map>
            <xsl:for-each select="('physical_body', 'eating', 'violence')">
                <xsl:map-entry key="." select="'meta-body'"/>
            </xsl:for-each>
            <xsl:for-each select="('law', 'music', 'science', 'writing')">
                <xsl:map-entry key="." select="'meta-disciplines'"/>
            </xsl:for-each>
            <xsl:for-each select="('emotion', 'loss', 'love', 'mind', 'solitude', 'uncertainty')">
                <xsl:map-entry key="." select="'meta-emotions'"/>
            </xsl:for-each>
            <xsl:for-each select="('nature', 'animal')">
                <xsl:map-entry key="." select="'meta-nature'"/>
            </xsl:for-each>
            <xsl:for-each select="('character')">
                <xsl:map-entry key="." select="'meta-relationships'"/>
            </xsl:for-each>
            <xsl:for-each select="('religion', 'supernatural')">
                <xsl:map-entry key="." select="'meta-religion'"/>
            </xsl:for-each>
            <xsl:for-each select="('social_norms', 'social_class', 'war', 'wealth', 'labor')">
                <xsl:map-entry key="." select="'meta-social'"/>
            </xsl:for-each>
            <xsl:for-each select="('childhood', 'memory', 'time')">
                <xsl:map-entry key="." select="'meta-time'"/>
            </xsl:for-each>
            <xsl:for-each select="('darkness', 'death', 'life', 'light')">
                <xsl:map-entry key="." select="'meta-abstract'"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>

    <!-- ============================================================ -->
    <!-- Templates                                                    -->
    <!-- ============================================================ -->
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Emily Dickinson &amp; Ellipsis</title>
                <link rel="stylesheet" type="text/css" href="reading_view.css"/>
                <script src="filter-poems.js"/>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css?family=Bitter%7COpen+Sans"/>
                <link rel="shortcut icon" type="image/jpeg" href="dickinson-portrait.jpeg"/>
            </head>
            <body>
                <!-- https://stackoverflow.com/questions/21147149/flash-of-unstyled-content-fouc-in-firefox-only-is-ff-slow-renderer -->
                <script>0</script>
                <!--=====================Website header and menu=================================-->
                <xsl:comment>#include virtual="website-header-and-navbar.html" </xsl:comment>

                <!--==================Checkboxes for filtering poems=================================-->
                <h1>Dickinson's Poems</h1>
                <div class="poems-filtering-box">
                    <h2 class="sidebar-header">I want to view poems by:</h2>
                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Time period written</h3>
                        <input type="checkbox" id="early" name="early" checked="checked"/>
                        <label for="early">Early (1850-1862)</label>
                        <br/>
                        <input type="checkbox" id="middle" name="middle" checked="checked"/>
                        <label for="middle">Middle (1863-1874)</label>
                        <br/>
                        <input type="checkbox" id="late" name="late" checked="checked"/>
                        <label for="late">Late (1875-1886)</label>
                        <br/>
                    </div>

                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Recipient</h3>
                        <input type="checkbox" id="yes-recipient" name="yes-recipient"
                            checked="checked"/>
                        <label for="yes-recipient">Yes</label>
                        <br/>
                        <input type="checkbox" id="no-recipient" name="no-recipient"
                            checked="checked"/>
                        <label for="no-recipient">No</label>
                        <br/>
                    </div>

                    <div class="poems-filtering-container">
                        <h3 class="sidebar-header">Ellipsis presence</h3>
                        <input type="checkbox" id="yes-ellipsis" name="yes-ellipsis"
                            checked="checked"/>
                        <label for="yes-ellipsis">Yes</label>
                        <br/>
                        <input type="checkbox" id="no-ellipsis" name="no-ellipsis" checked="checked"/>
                        <label for="no-ellipsis">No</label>
                        <br/>
                        <input type="checkbox" id="ambiguous-ellipsis" name="ambiguous-ellipsis"
                            checked="checked"/>
                        <label for="ambiguous-ellipsis">Ambiguous</label>
                        <br/>
                    </div>
                </div>

                <!--=====================Table of contents=============================================-->
                <div id="show-hide-table">
                    <div id="dropdownButton">
                        <h2>Not sure where to start? Click here to search!</h2>
                        <h3>(Click again to hide)</h3>
                    </div>
                    <table id="dropdownTable" class="dropdownContent hide">
                        <tr>
                            <th>First line / title</th>
                            <th>Date</th>
                            <th>Recipient?</th>
                            <th>Ellipsis present?</th>
                            <th>Themes</th>
                        </tr>
                        <xsl:apply-templates select="$poems_corpus//metadata" mode="table">
                            <xsl:sort select="date"/>
                        </xsl:apply-templates>
                    </table>
                </div>

                <!--=====================Sidebar: checkboxes for adding color to attributes=================================-->
                <div class="sidebar-textbox-align">
                    <div class="sidebar-box">
                        <h2 class="sidebar-header">I want to highlight:</h2>
                        <div id="sidebar-selecting-container">
                            <h3 class="sidebar-header">Theme</h3>

                            <input type="checkbox" id="meta-body" name="meta-body"/>
                            <label for="meta-body"><strong style="color:#FD216E;">The body and
                                    related concepts</strong> (eating, violence)</label>
                            <br/>
                            <input type="checkbox" id="meta-disciplines" name="meta-disciplines"/>
                            <label for="meta-disciplines"><strong style="color:#c97f14;"
                                    >Disciplines</strong> (law, music, science, writing)</label>
                            <br/>
                            <input type="checkbox" id="meta-emotions" name="meta-emotions"/>
                            <label for="meta-emotions"><strong style="color:#BBA2CD;">Emotions /
                                    state of mind</strong> (emotions, loss, love, the mind,
                                solitude, uncertainty)</label>
                            <br/>
                            <input type="checkbox" id="meta-nature" name="meta-nature"/>
                            <label for="meta-nature">
                                <strong style="color:#1B998B;">Nature and animals</strong>
                            </label>
                            <br/>
                            <input type="checkbox" id="meta-relationships" name="meta-relationships"/>
                            <label for="meta-relationships"><strong style="color:#D88C9A;"
                                    >Interpersonal relationships</strong> (characters and reference
                                to people)</label>
                            <br/>
                            <input type="checkbox" id="meta-religion" name="meta-religion"/>
                            <label for="meta-religion">
                                <strong style="color:#266DD3;">Religion and the
                                    supernatural</strong>
                            </label>
                            <br/>
                            <input type="checkbox" id="meta-social" name="meta-social"/>
                            <label for="meta-social"><strong style="color:#ECBB83;">Social
                                    constructs and allusions</strong> (social norms, social class,
                                war, wealth, labor)</label>
                            <br/>
                            <input type="checkbox" id="meta-time" name="meta-time"/>
                            <label for="meta-time"><strong style="color:#A72608;">Time-based
                                    experiences</strong> (childhood, memory, time)</label>
                            <br/>
                            <input type="checkbox" id="meta-abstract" name="meta-abstract"/>
                            <label for="meta-abstract"><strong style="color:#7F2CCB;">Other abstract
                                    concepts</strong> (life, death, light, darkness)</label>
                            <br/>
                        </div>
                    </div>

                    <!--Display the poems -->

                    <div class="text-box">
                        <xsl:apply-templates select="$poems_corpus">
                            <xsl:sort select="descendant::metadata/date"/>
                        </xsl:apply-templates>
                    </div>
                </div>
                <footer>
                    <img id="cc-license" alt="Creative Commons License"
                        src="https://i.creativecommons.org/l/by/4.0/88x31.png"/>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- METADATA FOR TABLE -->

    <xsl:template match="metadata" mode="table">
        <!-- ====================================================== -->
        <!-- Add class values for JavaScript filtering:             -->
        <!--   time period                                          -->
        <!--     source: date/@period                               -->
        <!--     value (xs:string): early, middle, late             -->
        <!--   ellipsis                                             -->
        <!--     source: ellipsis_present                           -->
        <!--     value (xs:string): yes-ellipsis, no-ellipsis       -->
        <!--   recipient                                            -->
        <!--     source: recipient                                  -->
        <!--     value (xs:string): yes-recipient, no-recipient     -->
        <!--                                                        -->
        <!-- Time period is copied from markup.                     -->
        <!-- Recipient values are generated:                        -->
        <!--   none -> no-recipient                                 -->
        <!--   any other value -> yes-recipient                     -->
        <!-- Ellipsis values are generated:                         -->
        <!--   yes -> yes-ellipsis                                  -->
        <!--   no -> no-ellipsis                                    -->
        <!--   ambiguous -> ambiguous-ellipsis                      -->
        <!-- ====================================================== -->
        <tr>
            <xsl:variable name="period" as="xs:string" select="date/@period"/>
            <xsl:variable name="ellipsis" as="xs:string" select="ellipsis_present || '-ellipsis'"/>
            <xsl:variable name="recipient" as="xs:string" select="
                    if (recipient eq 'none') then
                        'no-recipient'
                    else
                        'yes-recipient'"/>
            <xsl:attribute name="class" select="string-join(($period, $ellipsis, $recipient), ' ')"/>
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
    <xsl:template match="poem">
        <xsl:variable name="period" as="xs:string" select="metadata/date/@period"/>
        <xsl:variable name="ellipsis" as="xs:string"
            select="metadata/ellipsis_present || '-ellipsis'"/>
        <xsl:variable name="recipient" as="xs:string" select="
                if (metadata/recipient eq 'none') then
                    'no-recipient'
                else
                    'yes-recipient'"/>
        <div>
            <xsl:attribute name="class"
                select="string-join(('poem', $period, $ellipsis, $recipient), ' ')"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
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
        <xsl:choose>
            <xsl:when test="@v">
                <span class="tooltip">
                    <xsl:text>[v</xsl:text>
                    <xsl:apply-templates select="@v"/>
                    <xsl:text>...]</xsl:text> 
                    <span class="tooltiptext">
                    <xsl:apply-templates/>
                    <xsl:apply-templates select="@possible_string"/>
                    <xsl:if test="@v">
                        <xsl:text> (v</xsl:text>
                        <xsl:apply-templates select="@v"/>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                    <xsl:text> (</xsl:text>
                    <xsl:apply-templates select="@ellipsis_type"/>
                    <xsl:text>)</xsl:text>
                </span>
                </span>
            </xsl:when>
    
            <xsl:otherwise> 
                <span class="tooltip">[...] <span class="tooltiptext">
                    <xsl:apply-templates/>
                    <xsl:apply-templates select="@possible_string"/>
                    <xsl:text> (</xsl:text>
                    <xsl:apply-templates select="@ellipsis_type"/>
                    <xsl:text>)</xsl:text>
                    </span>
                </span>
            </xsl:otherwise>
        </xsl:choose>
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
        <!-- meta-theme is retrieved from stylesheet variable -->
        <xsl:if test="not(string-length(normalize-space(.)) eq 0)">
            <!-- currently we throw away empty theme elements (29 instances in corpus) -->
            <span class="{string-join((name(), $metatheme-by-theme(name())), ' ')}">
                <xsl:value-of select="normalize-space(.)"/>
            </span>
        </xsl:if>
    </xsl:template>
    <xsl:template match="
            text()
            [string-length(normalize-space(.)) eq 0]">
        <xsl:choose>
            <!-- 
                Suppress whitespace-only text nodes if:
                    1. Followed immediately by punctuation other than quotation mark
                       or dash (looks only at non-empty following siblings)
                    2. Preceded immediately by quotation mark
                    3. Followed immediately by quotation mark that 
                       is at the end of its <line>
                Otherwise: copy the whitespace into the outpout
            -->
            <xsl:when test="
                    following-sibling::*[not(string-length(normalize-space(.)) eq 0)][1]
                    [matches(., '^[^-A-Za-z&quot;]$')]"/>
            <xsl:when test="
                    preceding-sibling::*[1]
                    [. eq '&quot;']"/>
            <xsl:when test="
                    following-sibling::*[1]
                    [. eq '&quot;']
                    [not(following-sibling::*)]"/>
            <xsl:otherwise>
                <xsl:copy/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

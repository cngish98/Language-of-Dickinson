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
                        <h3 class="sidebar-header">Recipient / no recipient</h3>
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
                        <xsl:apply-templates select="$poems_corpus//metadata" mode="table"/>
                    </table>
                </div>

                <!--=====================Sidebar: checkboxes for adding color to attributes=================================-->
                <div class="sidebar-textbox-align">
                    <div class="sidebar-box">
                        <h2 class="sidebar-header">I want to highlight:</h2>

                        <div class="sidebar-selecting-container">
                            <h3 class="sidebar-header">Theme</h3>

                            <input type="checkbox" id="body" name="body"/>
                            <label for="body"><strong style="color:red;">The body and related
                                    concepts</strong> (eating, violence)</label>
                            <br/>
                            <input type="checkbox" id="disciplines" name="disciplines"/>
                            <label for="disciplines"><strong style="color:#f08d0c;"
                                    >Disciplines</strong> (law, music, science, writing)</label>
                            <br/>
                            <input type="checkbox" id="emotion" name="emotion"/>
                            <label for="emotion"><strong style="color:purple;">Emotions / state of
                                    mind</strong> (emotions, loss, love, the mind, solitude,
                                uncertainty)</label>
                            <br/>
                            <input type="checkbox" id="nature" name="nature"/>
                            <label for="nature">
                                <strong style="color:green;">Nature and animals</strong>
                            </label>
                            <br/>
                            <input type="checkbox" id="relationships" name="relationships"/>
                            <label for="relationships"><strong style="color:#d56cd9;">Interpersonal
                                    relationships</strong> (characters and reference to
                                people)</label>
                            <br/>
                            <input type="checkbox" id="religion" name="religion"/>
                            <label for="religion">
                                <strong style="color:#2a5fa3;">Religion and the
                                    supernatural</strong>
                            </label>
                            <br/>
                            <input type="checkbox" id="social" name="social"/>
                            <label for="social"><strong style="color:#b09012;">Social constructs and
                                    allusions</strong> (social norms, social class, war, wealth,
                                labor)</label>
                            <br/>
                            <input type="checkbox" id="time" name="time"/>
                            <label for="time"><strong style="color:#9b93bd;">Time-based
                                    experiences</strong> (childhood, memory, time)</label>
                            <br/>
                            <input type="checkbox" id="abstract" name="abstract"/>
                            <label for="abstract"><strong style="color:#88cf9f;">Other abstract
                                    concepts</strong> (life, death, light, darkness)</label>
                            <br/>
                        </div>
                    </div>

                    <!--Display the poems -->

                    <div class="text-box">
                        <xsl:apply-templates select="$poems_corpus"/>
                    </div>
                </div>
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
                        'yes-recipient'
                    else
                        'no-recipient'"/>
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
                    'yes-recipient'
                else
                    'no-recipient'"/>
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
        <span class="tooltip">[...] <span class="tooltiptext">
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

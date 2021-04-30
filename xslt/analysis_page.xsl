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
                <link rel="stylesheet" type="text/css" href="dickinson-simple.css"/>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css?family=Bitter%7COpen+Sans"/>
                <script src="show-hide-methods-explanation.js"/>
                <link rel="shortcut icon" type="image/jpeg" href="dickinson-portrait.jpeg"/>
            </head>
            <body>
                <!--=====================Website header and menu=================================-->
                <xsl:comment>#include virtual="website-header-and-navbar.html" </xsl:comment>

                <!--=====================Methodology explanation=================================-->
                <div class="text-content">
                    <h1 style="text-align:center;">OUR METHODOLOGY: an explanation</h1>
                    <div class="dropdownButton">
                        <button onclick="hideDropdown()" class="dropdownButton">(Click here to show
                            / hide this explanation)</button>
                    </div>
                    <div class="text-box dropdownContent show" id="methods-text">
                        <div>
                            <h4>Selecting the markup</h4>
                            <p>To begin our mark up, we selected 90 poems from the <a
                                    href="https://www.edickinson.org">Emily Dickinson Archive</a>
                                that span her career. We tried to find a representative sample of
                                poems that feature not only different time periods, but diverse
                                recipients, types of imagery, and stylistic choices. </p>

                            <p>Dickinson was an active poet between the years 1850-1886. Thus, we
                                divided her work into early, middle, and late periods as
                                follows:</p>

                            <ul>
                                <li><strong>Early: </strong>1850-1862</li>
                                <li><strong>Middle: </strong>1863-1874</li>
                                <li><strong>Late: </strong>1875-1886</li>
                            </ul>

                            <h4>Imagery markup</h4>
                            <p>Our group discussed some of the common themes shown in Dickinson's
                                work, such as nature, religion, writing, and emotion. We
                                incorporated these themes into our schema and tagged any instances
                                of them that we noticed in the poems.</p>

                            <h4>Elision markup</h4>
                            <p>Elision was categorized as nominal, verbal, or clausal.</p>
                            <p>(talk about v tag here?)</p>
                        </div>
                    </div>
                    
                    <!-- I think there needs to be an h1 "RESULTS" here like we have for "OUR METHODOLOGY: an explanation" -->
                    
                    <!--=====================Simple ellipsis count graphs=================================-->
                    <div class="text-box">
                        <h3>How many of our poems contain ellipsis?</h3>
                        <h3>How many times does ellipsis occur throughout the poems?</h3>
                    </div>

                    <!--=====================Theme count graph=================================-->
                    
                    <div class="text-box">
                        <h3>How many poems contain a particular theme? Which themes?</h3>
                    </div>

                    <!--=====================Correlations between ellipsis and recipient=============================-->
                    
                    <!--I would reference the table-just-one.xslt and table-split.xslt files to see more
                            about how I applied templates from the corpus. You could also check the 
                            reading-view.xslt itself too! -->
                    <div class="text-box">
                        <h3>Comparing ellipsis with presence of recipient</h3> <!--edit this title probably!?-->
                        <table>
                            <tr>
                                <th>Ellipsis presence</th>
                                <th>Count of poems with recipient</th>
                                <th>Count of poems with no recipient</th>
                            </tr>
                            <tr>
                                <td>Yes</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::recipient[. != 'none'])"/><!--insert number of yes ellipsis / yes recipient poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::recipient[. = 'none'])"/><!--insert number of yes ellipsis / no recipient poems here --></td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::recipient[. != 'none'])"/><!--insert number of no ellipsis / yes recipient poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::recipient[. = 'none'])"/><!--insert number of no ellipsis / no recipient poems here --></td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::recipient[. != 'none'])"/><!--insert number of ambig ellipsis / yes recipient poems here 
                                for example, this value should be 3 out of 90 poems--></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::recipient[. = 'none'])"/><!--insert number of ambig ellipsis / no recipient poems here --></td>
                            </tr>
                        </table>
                    </div>

                    <!--=====================Correlations between ellipsis and time period=================================-->
                    
                    <div class="text-box">
                        <h3>Comparing ellipsis with the time period the poems were written in</h3> <!--edit this title probably!?-->
                        <table> 
                            <tr>
                                <th>Ellipsis presence</th>
                                <th>Early period</th>
                                <th>Middle period</th>
                                <th>Late period</th>
                            </tr>
                            <tr>
                                <td>Yes</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'early'])"/><!--insert number of yes ellipsis / early period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'middle'])"/><!--insert number of yes ellipsis / middle period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'late'])"/><!--insert number of yes ellipsis / late period poems here --></td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'early'])"/><!--insert number of no ellipsis / early period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'middle'])"/><!--insert number of no ellipsis / middle period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'late'])"/><!--insert number of no ellipsis / late period poems here --></td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'early'])"/><!--insert number of ambig ellipsis / early period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'middle'])"/><!--insert number of ambig ellipsis / middle period poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'late'])"/><!--insert number of ambig ellipsis / late period poems here --></td>
                            </tr>
                        </table>
                    </div>
                    
                    
                    <!--=====================Correlations between ellipsis and (28) themes=================================-->
                    
                    <div class="text-box">
                        <h3>Comparing ellipsis with themes present in the poems</h3> 
                        <!--edit this title probably!?-->
                        <table> 
                            <tr>
                                <th>Ellipsis presence</th>
                                <!--I have these in alphabetical order, but feel free to change it.
                                Also left out  poems that have 5 or less instances of a theme.
                                Feel free to change that too if you think that's too much.
                                
                                ALSO NOTE: This table does not fit within the text box on the website 
                                just because it is so big. There is probably a way to fix it but I'm
                                not sure. Either way, lmk what you think.-->
                                <th>Death</th>
                                <th>Emotion</th>
                                <th>Life</th>
                                <th>Love</th>
                                <th>Nature</th>
                                <th>Relationships</th>
                                <th>Religion</th>
                                <th>Solitude</th>
                                <th>The mind</th>
                                <th>Time</th>
                                <th>Writing</th>
                            </tr>
                            <tr>
                                <td>Yes</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'death'])"/><!--insert number of yes ellipsis / death themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/><!--insert number of yes ellipsis / emotion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'life'])"/><!--insert number of yes ellipsis / life themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'love'])"/><!--insert number of yes ellipsis / love themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'nature'])"/><!--insert number of yes ellipsis / nature themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/><!--insert number of yes ellipsis / relationships themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'religion'])"/><!--insert number of yes ellipsis / religion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/><!--insert number of yes ellipsis / solitude themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/><!--insert number of yes ellipsis / the mind themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'time'])"/><!--insert number of yes ellipsis / time themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'writing'])"/><!--insert number of yes ellipsis / writing themed poems here --></td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'death'])"/><!--insert number of no ellipsis / death themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/><!--insert number of no ellipsis / emotion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'life'])"/><!--insert number of no ellipsis / life themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'love'])"/><!--insert number of no ellipsis / love themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'nature'])"/><!--insert number of no ellipsis / nature themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/><!--insert number of no ellipsis / relationships themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'religion'])"/><!--insert number of no ellipsis / religion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/><!--insert number of no ellipsis / solitude themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/><!--insert number of no ellipsis / the mind themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'time'])"/><!--insert number of no ellipsis / time themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'writing'])"/><!--insert number of no ellipsis / writing themed poems here --></td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td> <!--this section maybe we can make smaller, since the purely
                                    ambiguous poems are very small --> 
                                    <!-- CG: I'm wondering if we even need this ambiguous row at all because all the counts
                                    are 0 other than 2 (religion and time) and even then, the counts are only 1 for each-->
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'death'])"/><!--insert number of ambig ellipsis / death themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/><!--insert number of ambig ellipsis / emotion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'life'])"/><!--insert number of ambig ellipsis / life themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'love'])"/><!--insert number of ambig ellipsis / love themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'nature'])"/><!--insert number of ambig ellipsis / nature themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/><!--insert number of ambig ellipsis / relationships themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'religion'])"/><!--insert number of ambig ellipsis / religion themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/><!--insert number of ambig ellipsis / solitude themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/><!--insert number of ambig ellipsis / the mind themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'time'])"/><!--insert number of ambig ellipsis / time themed poems here --></td>
                                <td><xsl:apply-templates select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'writing'])"/><!--insert number of ambig ellipsis / writing themed poems here --></td>
                            </tr>
                        </table>
                    </div>
                </div> <!--Make sure this </div> stays at the very end of all the data,
                so if we add any more text boxes put them before this </div>-->
                
                
                
                <!--=====================CC License=================================-->
                
                <footer>
                    <img id="cc-license" alt="Creative Commons License"
                        src="https://i.creativecommons.org/l/by/4.0/88x31.png"/>
                </footer>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

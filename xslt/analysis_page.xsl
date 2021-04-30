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

                    <h1 style="text-align:center;">RESULTS</h1>

                    <!--=====================Simple ellipsis count graphs=================================-->
                    <div class="text-box">
                        <!---=========Ellipsis presence graph=====-->
                        <h3>How many of our poems contain ellipsis?</h3>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-150 100 900 600" width="100%"
                            class="ellipsis-graph">
                            <g transform="translate(80,600)">
                                <line x1="0" y1="-112.5" x2="500" y2="-112.5" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-225" x2="500" y2="-225" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-337.5" x2="500" y2="-337.5" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-450" x2="500" y2="-450" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" x2="500" y1="0" y2="0" stroke="black" stroke-width="2"
                                    stroke-linecap="square"/>
                                <line x1="0" x2="0" y1="0" y2="-450" stroke="black" stroke-width="2"
                                    stroke-linecap="square"/>
                                <text x="-15" y="0" text-anchor="middle">0</text>
                                <text x="-15" y="-225" text-anchor="middle">45</text>
                                <text x="-15" y="-450" text-anchor="middle">90</text>
                                <text x="-50" y="-225" text-anchor="middle" writing-mode="tb"
                                    font-size="x-large">Total number of poems in our corpus</text>
                                <text x="250" y="60" text-anchor="middle" font-size="x-large"
                                    >Ellipsis presence?</text>
                                <rect x="50" y="-340" height="340" width="100" stroke="black"
                                    stroke-width=".5" fill="#A2A77F"/>
                                <text x="100" y="30" text-anchor="middle" font-size="large"
                                    >yes</text>
                                <text x="100" y="-350" text-anchor="middle" fill="black"
                                    font-size="medium">68</text>
                                <rect x="200" y="-85" height="85" width="100" stroke="black"
                                    stroke-width=".5" fill="#4F759B"/>
                                <text x="250" y="30" text-anchor="middle" font-size="large"
                                    >no</text>
                                <text x="250" y="-95" text-anchor="middle" fill="black"
                                    font-size="medium">17</text>
                                <rect x="350" y="-25" height="25" width="100" stroke="black"
                                    stroke-width=".5" fill="#945780"/>
                                <text x="400" y="30" text-anchor="middle" font-size="large"
                                    >ambiguous</text>
                                <text x="400" y="-35" text-anchor="middle" fill="black"
                                    font-size="medium">5</text>
                            </g>
                        </svg>
                        <!---=========Ellipsis types graph=====-->
                        <h3>How many times does ellipsis occur throughout the poems? What types of ellipsis?</h3>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-100 100 950 600" width="100%"
                            class="ellipsis-graph">
                            <g transform="translate(80,600)">
                                <line x1="0" y1="-112.5" x2="630" y2="-112.5" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-225" x2="630" y2="-225" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-337.5" x2="630" y2="-337.5" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" y1="-450" x2="630" y2="-450" stroke="grey"
                                    stroke-dasharray="4 4 4" stroke-width="2"/>
                                <line x1="0" x2="630" y1="0" y2="0" stroke="black" stroke-width="2"
                                    stroke-linecap="square"/>
                                <line x1="0" x2="0" y1="0" y2="-450" stroke="black" stroke-width="2"
                                    stroke-linecap="square"/>
                                <text x="-15" y="0" text-anchor="middle">0</text>
                                <text x="-15" y="-225" text-anchor="middle">45</text>
                                <text x="-15" y="-450" text-anchor="middle">90</text>
                                <text x="-50" y="-225" text-anchor="middle" writing-mode="tb"
                                    font-size="x-large">Total times encountered</text>
                                <text x="315" y="70" text-anchor="middle" font-size="x-large">Types
                                    of ellipsis</text>
                                <rect x="50" y="-75" height="75" width="100" stroke="black"
                                    stroke-width=".5" fill="#945780"/>
                                <text x="100" y="30" text-anchor="middle" font-size="large"
                                    >ambiguous</text>
                                <text x="100" y="-85" text-anchor="middle" fill="black"
                                    font-size="medium">15</text>
                                <rect x="200" y="-400" height="400" width="100" stroke="black"
                                    stroke-width=".5" fill="#7681B3"/>
                                <text x="250" y="30" text-anchor="middle" font-size="large"
                                    >clausal</text>
                                <text x="250" y="-410" text-anchor="middle" fill="black"
                                    font-size="medium">80</text>
                                <rect x="350" y="-185" height="185" width="100" stroke="black"
                                    stroke-width=".5" fill="#A2A77F"/>
                                <text x="400" y="30" text-anchor="middle" font-size="large"
                                    >nominal</text>
                                <text x="400" y="-195" text-anchor="middle" fill="black"
                                    font-size="medium">37</text>
                                <rect x="500" y="-235" height="235" width="100" stroke="black"
                                    stroke-width=".5" fill="#4F759B"/>
                                <text x="550" y="30" text-anchor="middle" font-size="large"
                                    >verbal</text>
                                <text x="550" y="-245" text-anchor="middle" fill="black"
                                    font-size="medium">47</text>
                            </g>
                        </svg>
                    </div>

                    <!--=====================Theme count graph=================================-->

                    <div class="text-box">
                        <h3>How many poems contain a particular theme? Which themes?</h3>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-100 -500 1718 600"
                            width="100%">
                            <g>
                                <line x1="0" x2="1568" y1="-240" y2="-240" stroke="lightgray"
                                    stroke-dasharray="8 4" stroke-width="1"/>
                                <line x1="0" x2="1568" y1="-120" y2="-120" stroke="lightgray"
                                    stroke-dasharray="8 4" stroke-width="1"/>
                                <line x1="0" x2="1568" y1="-360" y2="-360" stroke="lightgray"
                                    stroke-dasharray="8 4" stroke-width="1"/>
                                <rect x="14" y="-60" stroke="black" stroke-width=".5" fill="#1B998B"
                                    width="28" height="60"/>
                                <text x="28" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 28, 10)">animal</text>
                                <text x="28" y="-65" text-anchor="middle" fill="black"
                                    font-size="small">6</text>
                                <rect x="70" y="-10" stroke="black" stroke-width=".5" fill="#A72608"
                                    width="28" height="10"/>
                                <text x="84" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 84, 10)">childhood</text>
                                <text x="84" y="-15" text-anchor="middle" fill="black"
                                    font-size="small">1</text>
                                <rect x="126" y="-30" stroke="black" stroke-width=".5"
                                    fill="#7F2CCB" width="28" height="30"/>
                                <text x="140" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 140, 10)">darkness</text>
                                <text x="140" y="-35" text-anchor="middle" fill="black"
                                    font-size="small">3</text>
                                <rect x="182" y="-120" stroke="black" stroke-width=".5"
                                    fill="#7F2CCB" width="28" height="120"/>
                                <text x="196" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 196, 10)">death</text>
                                <text x="196" y="-125" text-anchor="middle" fill="black"
                                    font-size="small">12</text>
                                <rect x="238" y="-10" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="10"/>
                                <text x="252" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 252, 10)">eating</text>
                                <text x="252" y="-15" text-anchor="middle" fill="black"
                                    font-size="small">1</text>
                                <rect x="294" y="-120" stroke="black" stroke-width=".5"
                                    fill="#BBA2CD" width="28" height="120"/>
                                <text x="308" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 308, 10)">emotion</text>
                                <text x="308" y="-125" text-anchor="middle" fill="black"
                                    font-size="small">12</text>
                                <rect x="350" y="-20" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="20"/>
                                <text x="364" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 364, 10)">labor</text>
                                <text x="364" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="406" y="-20" stroke="black" stroke-width=".5"
                                    fill="#c97f14" width="28" height="20"/>
                                <text x="420" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 420, 10)">law</text>
                                <text x="420" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="462" y="-70" stroke="black" stroke-width=".5"
                                    fill="#7F2CCB" width="28" height="70"/>
                                <text x="476" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 476, 10)">life</text>
                                <text x="476" y="-75" text-anchor="middle" fill="black"
                                    font-size="small">7</text>
                                <rect x="518" y="-50" stroke="black" stroke-width=".5"
                                    fill="#7F2CCB" width="28" height="50"/>
                                <text x="532" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 532, 10)">light</text>
                                <text x="532" y="-55" text-anchor="middle" fill="black"
                                    font-size="small">5</text>
                                <rect x="574" y="-90" stroke="black" stroke-width=".5"
                                    fill="#BBA2CD" width="28" height="90"/>
                                <text x="588" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 588, 10)">love</text>
                                <text x="588" y="-95" text-anchor="middle" fill="black"
                                    font-size="small">9</text>
                                <rect x="630" y="-20" stroke="black" stroke-width=".5"
                                    fill="#A72608" width="28" height="20"/>
                                <text x="644" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 644, 10)">memory</text>
                                <text x="644" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="686" y="-20" stroke="black" stroke-width=".5"
                                    fill="#c97f14" width="28" height="20"/>
                                <text x="700" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 700, 10)">music</text>
                                <text x="700" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="742" y="-440" stroke="black" stroke-width=".5"
                                    fill="#1B998B" width="28" height="440"/>
                                <text x="756" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 756, 10)">nature</text>
                                <text x="756" y="-445" text-anchor="middle" fill="black"
                                    font-size="small">44</text>
                                <rect x="798" y="-80" stroke="black" stroke-width=".5"
                                    fill="#D88C9A" width="28" height="80"/>
                                <text x="812" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 812, 10)">relationships</text>
                                <text x="812" y="-85" text-anchor="middle" fill="black"
                                    font-size="small">8</text>
                                <rect x="854" y="-140" stroke="black" stroke-width=".5"
                                    fill="#266DD3" width="28" height="140"/>
                                <text x="868" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 868, 10)">religion</text>
                                <text x="868" y="-145" text-anchor="middle" fill="black"
                                    font-size="small">14</text>
                                <rect x="910" y="-30" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="30"/>
                                <text x="924" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 924, 10)">social class</text>
                                <text x="924" y="-35" text-anchor="middle" fill="black"
                                    font-size="small">3</text>
                                <rect x="966" y="-20" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="20"/>
                                <text x="980" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 980, 10)">social norms</text>
                                <text x="980" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="1022" y="-60" stroke="black" stroke-width=".5"
                                    fill="#BBA2CD" width="28" height="60"/>
                                <text x="1036" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1036, 10)">solitude</text>
                                <text x="1036" y="-65" text-anchor="middle" fill="black"
                                    font-size="small">6</text>
                                <rect x="1078" y="-10" stroke="black" stroke-width=".5"
                                    fill="#266DD3" width="28" height="10"/>
                                <text x="1092" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1092, 10)">supernatural</text>
                                <text x="1092" y="-15" text-anchor="middle" fill="black"
                                    font-size="small">1</text>
                                <rect x="1134" y="-50" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="50"/>
                                <text x="1148" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1148, 10)">the body</text>
                                <text x="1148" y="-55" text-anchor="middle" fill="black"
                                    font-size="small">5</text>
                                <rect x="1190" y="-70" stroke="black" stroke-width=".5"
                                    fill="#BBA2CD" width="28" height="70"/>
                                <text x="1204" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1204, 10)">the mind</text>
                                <text x="1204" y="-75" text-anchor="middle" fill="black"
                                    font-size="small">7</text>
                                <rect x="1246" y="-120" stroke="black" stroke-width=".5"
                                    fill="#A72608" width="28" height="120"/>
                                <text x="1260" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1260, 10)">time</text>
                                <text x="1260" y="-125" text-anchor="middle" fill="black"
                                    font-size="small">12</text>
                                <rect x="1302" y="-40" stroke="black" stroke-width=".5"
                                    fill="#BBA2CD" width="28" height="40"/>
                                <text x="1316" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1316, 10)">uncertainty</text>
                                <text x="1316" y="-45" text-anchor="middle" fill="black"
                                    font-size="small">4</text>
                                <rect x="1358" y="-50" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="50"/>
                                <text x="1372" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1372, 10)">violence</text>
                                <text x="1372" y="-55" text-anchor="middle" fill="black"
                                    font-size="small">5</text>
                                <rect x="1414" y="-30" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="30"/>
                                <text x="1428" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1428, 10)">war</text>
                                <text x="1428" y="-35" text-anchor="middle" fill="black"
                                    font-size="small">3</text>
                                <rect x="1470" y="-20" stroke="black" stroke-width=".5"
                                    fill="#FD216E" width="28" height="20"/>
                                <text x="1484" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1484, 10)">wealth</text>
                                <text x="1484" y="-25" text-anchor="middle" fill="black"
                                    font-size="small">2</text>
                                <rect x="1526" y="-60" stroke="black" stroke-width=".5"
                                    fill="#c97f14" width="28" height="60"/>
                                <text x="1540" y="20" text-anchor="start" font-size="medium"
                                    transform="rotate(25, 1540, 10)">writing</text>
                                <text x="1540" y="-65" text-anchor="middle" fill="black"
                                    font-size="small">6</text>
                                <line x1="0" x2="1568" y1="0" y2="0" stroke="black" stroke-width="1"
                                    stroke-linecap="square"/>
                                <line x1="0" x2="0" y1="0" y2="-480" stroke="black" stroke-width="1"
                                    stroke-linecap="square"/>
                                <text x="-5" y="0" text-anchor="end" dominant-baseline="middle"
                                    >0</text>
                                <text x="-5" y="-240" text-anchor="end" dominant-baseline="middle"
                                    >24</text>
                                <text x="-5" y="-480" text-anchor="end" dominant-baseline="middle"
                                    >48</text>
                                <text x="-5" y="-120" text-anchor="end" dominant-baseline="middle"
                                    >12</text>
                                <text x="-5" y="-360" text-anchor="end" dominant-baseline="middle"
                                    >36</text>
                                <text x="784" y="100" text-anchor="middle" font-size="x-large">Poem
                                    theme</text>
                                <text x="-50" y="-225" text-anchor="middle" writing-mode="tb"
                                    font-size="x-large">Number of poems containing theme</text>
                            </g>
                        </svg>
                        <p>We colored the bars here according to the color of the 9 themes available
                        to highlight on our corpus page.</p>
                    </div>

                    <!--=====================Correlations between ellipsis and recipient=============================-->

                    <div class="text-box">
                        <h3>Comparing ellipsis with presence of recipient</h3>
                        <!--edit this title probably!?-->
                        <table>
                            <tr>
                                <th>Ellipsis presence</th>
                                <th>Count of poems with recipient</th>
                                <th>Count of poems with no recipient</th>
                            </tr>
                            <tr>
                                <td>Yes</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::recipient[. != 'none'])"/>
                                    <!--insert number of yes ellipsis / yes recipient poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::recipient[. = 'none'])"/>
                                    <!--insert number of yes ellipsis / no recipient poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::recipient[. != 'none'])"/>
                                    <!--insert number of no ellipsis / yes recipient poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::recipient[. = 'none'])"/>
                                    <!--insert number of no ellipsis / no recipient poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::recipient[. != 'none'])"/>
                                    <!--insert number of ambig ellipsis / yes recipient poems here 
                                for example, this value should be 3 out of 90 poems-->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::recipient[. = 'none'])"/>
                                    <!--insert number of ambig ellipsis / no recipient poems here -->
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!--=====================Correlations between ellipsis and time period=================================-->

                    <div class="text-box">
                        <h3>Comparing ellipsis with the time period the poems were written in</h3>
                        <!--edit this title probably!?-->
                        <table>
                            <tr>
                                <th>Ellipsis presence</th>
                                <th>Early period</th>
                                <th>Middle period</th>
                                <th>Late period</th>
                            </tr>
                            <tr>
                                <td>Yes</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'early'])"/>
                                    <!--insert number of yes ellipsis / early period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'middle'])"/>
                                    <!--insert number of yes ellipsis / middle period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::date[@period = 'late'])"/>
                                    <!--insert number of yes ellipsis / late period poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'early'])"/>
                                    <!--insert number of no ellipsis / early period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'middle'])"/>
                                    <!--insert number of no ellipsis / middle period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::date[@period = 'late'])"/>
                                    <!--insert number of no ellipsis / late period poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'early'])"/>
                                    <!--insert number of ambig ellipsis / early period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'middle'])"/>
                                    <!--insert number of ambig ellipsis / middle period poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::date[@period = 'late'])"/>
                                    <!--insert number of ambig ellipsis / late period poems here -->
                                </td>
                            </tr>
                        </table>
                    </div>


                    <!--=====================Correlations between ellipsis and (28) themes=================================-->

                    <div class="text-box" id="themes-table-box">
                        <h3>Comparing ellipsis with themes present in the poems</h3>
                        <!--edit this title probably!?-->
                        <table id="themes-table">
                            <tr>
                                <th>Ellipsis presence</th>

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
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'death'])"/>
                                    <!--insert number of yes ellipsis / death themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/>
                                    <!--insert number of yes ellipsis / emotion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'life'])"/>
                                    <!--insert number of yes ellipsis / life themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'love'])"/>
                                    <!--insert number of yes ellipsis / love themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'nature'])"/>
                                    <!--insert number of yes ellipsis / nature themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/>
                                    <!--insert number of yes ellipsis / relationships themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'religion'])"/>
                                    <!--insert number of yes ellipsis / religion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/>
                                    <!--insert number of yes ellipsis / solitude themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/>
                                    <!--insert number of yes ellipsis / the mind themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'time'])"/>
                                    <!--insert number of yes ellipsis / time themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'yes']/preceding-sibling::poem_themes/theme[. = 'writing'])"/>
                                    <!--insert number of yes ellipsis / writing themed poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>No</td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'death'])"/>
                                    <!--insert number of no ellipsis / death themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/>
                                    <!--insert number of no ellipsis / emotion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'life'])"/>
                                    <!--insert number of no ellipsis / life themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'love'])"/>
                                    <!--insert number of no ellipsis / love themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'nature'])"/>
                                    <!--insert number of no ellipsis / nature themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/>
                                    <!--insert number of no ellipsis / relationships themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'religion'])"/>
                                    <!--insert number of no ellipsis / religion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/>
                                    <!--insert number of no ellipsis / solitude themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/>
                                    <!--insert number of no ellipsis / the mind themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'time'])"/>
                                    <!--insert number of no ellipsis / time themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'no']/preceding-sibling::poem_themes/theme[. = 'writing'])"/>
                                    <!--insert number of no ellipsis / writing themed poems here -->
                                </td>
                            </tr>
                            <tr>
                                <td>Ambiguous</td>
                                <!--this section maybe we can make smaller, since the purely
                                    ambiguous poems are very small -->
                                <!-- CG: I'm wondering if we even need this ambiguous row at all because all the counts
                                    are 0 other than 2 (religion and time) and even then, the counts are only 1 for each-->
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'death'])"/>
                                    <!--insert number of ambig ellipsis / death themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'emotion'])"/>
                                    <!--insert number of ambig ellipsis / emotion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'life'])"/>
                                    <!--insert number of ambig ellipsis / life themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'love'])"/>
                                    <!--insert number of ambig ellipsis / love themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'nature'])"/>
                                    <!--insert number of ambig ellipsis / nature themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'relationships'])"/>
                                    <!--insert number of ambig ellipsis / relationships themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'religion'])"/>
                                    <!--insert number of ambig ellipsis / religion themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'solitude'])"/>
                                    <!--insert number of ambig ellipsis / solitude themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'the mind'])"/>
                                    <!--insert number of ambig ellipsis / the mind themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'time'])"/>
                                    <!--insert number of ambig ellipsis / time themed poems here -->
                                </td>
                                <td>
                                    <xsl:apply-templates
                                        select="count($poems_corpus//ellipsis_present[. = 'ambiguous']/preceding-sibling::poem_themes/theme[. = 'writing'])"/>
                                    <!--insert number of ambig ellipsis / writing themed poems here -->
                                </td>
                            </tr>
                        </table>
                        <p>We left out themes that appear in 5 or less poems.</p>
                    </div>
                </div>
                <!--Make sure this </div> stays at the very end of all the data,
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

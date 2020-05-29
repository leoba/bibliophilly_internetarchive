<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ms="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:html="http://www.w3.org/TR/REC-html40"
    version="2.0">
    <xsl:output omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="spreadsheet.csv">"identifier","file","description","subject[0]","subject[1]","subject[2]","title","creator","date","collection","language","licenseurl","rights","contributor","credits"<xsl:for-each select="collection(iri-to-uri('../bibliophilly_internetarchive/TEI/?select=*.xml;recurse=yes'))">
            <xsl:variable name="institution" select="//tei:institution"/>
            <xsl:variable name="repository" select="//tei:repository"/>
            <xsl:variable name="title" select="//tei:msContents/tei:msItem[1]/tei:title"/>
            <xsl:variable name="callNo" select="//tei:msIdentifier/tei:idno[@type='call-number']"/>
            <xsl:variable name="lang" select="//tei:textLang/@mainLang"/>
            <xsl:variable name="date" select="replace(//tei:origin/tei:p,'&quot;','')"/>
            <xsl:variable name="summary" select="replace(//tei:summary,'&quot;','')"/>
            <xsl:variable name="compuDate">
                <xsl:for-each select="//tei:origin">
                    <xsl:choose>
                        <xsl:when test="tei:origDate[1]/@notBefore"><xsl:value-of select="tei:origDate[1]/@notBefore"/></xsl:when>
                        <xsl:when test="tei:origDate[2]/@notBefore"><xsl:value-of select="tei:origDate[2]/@notBefore"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="tei:origDate[1]/@when"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="place" select="//tei:origin/tei:origPlace"></xsl:variable>
            <xsl:variable name="keyword1" select="//tei:keywords[@n='keywords']/tei:term[1]"/>
            <xsl:variable name="keyword2" select="//tei:keywords[@n='keywords']/tei:term[2]"/>
            <xsl:variable name="keyword3" select="//tei:keywords[@n='keywords']/tei:term[3]"/>
            <xsl:variable name="msCode" select="tokenize(replace(document-uri(.),'_TEI.xml',''),'/') [position() = last()]"/>
            <xsl:variable name="fileName" select="concat($msCode,'.pdf')"/>
"<xsl:value-of select="$msCode"/>","<xsl:value-of select="$fileName"/>","<xsl:value-of select="$repository"/>, <xsl:value-of select="$callNo"/>. <xsl:value-of select="$place"/>, <xsl:value-of select="$date"/>. <xsl:value-of select="$summary"/>","<xsl:value-of select="$keyword1"/>","<xsl:value-of select="$keyword2"/>","<xsl:value-of select="$keyword3"/>","<xsl:value-of select="$title"/>","<xsl:value-of select="$repository"/>","<xsl:value-of select="$compuDate"/>","upenn","<xsl:value-of select="$lang"/>","http://creativecommons.org/publicdomain/mark/1.0/","Public Domain","Upenn Code (need to get)","Digitized through the Bibliotheca Philadelphiensis project. Bibliotheca Philadelphiensis is supported by a Digitizing Hidden Collections grant from the Council on Library and Information Resources (CLIR). The grant program is made possible by funding from The Andrew W. Mellon Foundation."</xsl:for-each></xsl:result-document></xsl:template>
    
</xsl:stylesheet>
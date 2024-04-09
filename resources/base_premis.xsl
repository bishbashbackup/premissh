<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:premis="http://www.loc.gov/premis/v3"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
<xsl:output method="xml" indent="yes"/>
	
<xsl:template match="/">
	<premis:premis xmlns="http://www.loc.gov/premis/v3"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xsi:schemaLocation="http://www.loc.gov/premis/v3 https://www.loc.gov/standards/premis/premis.xsd" 
		version="3.0">
		<xsl:apply-templates select="DATA/EVENT" />
		<xsl:apply-templates select="DATA/DROIDINFO" />
		<xsl:apply-templates select="DATA/OBJECT" />
	</premis:premis>
</xsl:template>

<xsl:template match="EVENT">
	<premis:event>
		<premis:eventIdentifier>
			<premis:eventIdentifierType>UUID</premis:eventIdentifierType>
        	<premis:eventIdentifierValue><xsl:apply-templates select="ID"/></premis:eventIdentifierValue>
    	</premis:eventIdentifier>
		<premis:eventType authority="eventType" authorityURI="https://id.loc.gov/vocabulary/preservation/eventType" valueURI="http://id.loc.gov/vocabulary/preservation/eventRelatedAgentRole/for">format identification</premis:eventType>
		<premis:eventDateTime><xsl:apply-templates select="DATE"/></premis:eventDateTime>
		<premis:linkingAgentIdentifier>
        	<premis:linkingAgentIdentifierType>local</premis:linkingAgentIdentifierType>
        	<premis:linkingAgentIdentifierValue>DROID</premis:linkingAgentIdentifierValue>
        	<premis:linkingAgentRole authority="eventRelatedAgentRole" authorityURI="http://id.loc.gov/vocabulary/preservation/eventRelatedAgentRole" valueURI="http://id.loc.gov/vocabulary/preservation/eventRelatedAgentRole/exe">executing program</premis:linkingAgentRole>
    	</premis:linkingAgentIdentifier>
    </premis:event>
</xsl:template>

<xsl:template match="DROIDINFO">
	<premis:agent>
  		<premis:agentIdentifier>
    		<premis:agentIdentifierType>local</premis:agentIdentifierType>
      		<premis:agentIdentifierValue>DROID</premis:agentIdentifierValue>
    	</premis:agentIdentifier>
		<premis:agentName>DROID</premis:agentName>
    	<premis:agentType authority="agentType" authorityURI="http://id.loc.gov/vocabulary/preservation/agentType" valueURI="http://id.loc.gov/vocabulary/preservation/agentType/sof">software</premis:agentType>
		<premis:agentVersion><xsl:apply-templates select="VERSION"/></premis:agentVersion>
		<premis:agentNote><xsl:apply-templates select="SIGNATURES"/></premis:agentNote>
	</premis:agent>
 </xsl:template>

<xsl:template match="OBJECT">
	<premis:object xsi:type="premis:file">
		<premis:objectIdentifier>
			<premis:objectIdentifierType>local</premis:objectIdentifierType>
			<premis:objectIdentifierValue><xsl:apply-templates select="BASE/NAME" /></premis:objectIdentifierValue>
		</premis:objectIdentifier>
		<premis:objectCharacteristics>
			<premis:compositionLevel>0</premis:compositionLevel>
			<premis:fixity>
				<premis:messageDigestAlgorithm>SHA-256</premis:messageDigestAlgorithm>
				<premis:messageDigest><xsl:apply-templates select="DROID/HASH" /></premis:messageDigest>
				<premis:messageDigestOriginator>DROID</premis:messageDigestOriginator>
			</premis:fixity>
			<premis:size><xsl:apply-templates select="DROID/SIZE" /></premis:size>
			<premis:format>
				<premis:formatDesignation>
					<premis:formatName><xsl:apply-templates select="DROID/FORMAT_NAME" /></premis:formatName>
					<premis:formatVersion><xsl:apply-templates select="DROID/FORMAT_VERSION" /></premis:formatVersion>
				</premis:formatDesignation>
				<premis:formatRegistry>
					<premis:formatRegistryName>PRONOM</premis:formatRegistryName>
					<premis:formatRegistryKey><xsl:apply-templates select="DROID/PUID" /></premis:formatRegistryKey>
				</premis:formatRegistry>
			</premis:format>
			<xsl:if test="string(BASE/SOFTWARE) or string(BASE/CREATION_DATE)">
				<premis:creatingApplication>
					<xsl:if test="string(BASE/SOFTWARE)">
						<premis:creatingApplicationName><xsl:apply-templates select="BASE/SOFTWARE" /></premis:creatingApplicationName>
					</xsl:if>
					<xsl:if test="string(BASE/CREATION_DATE)">
						<premis:dateCreatedByApplication><xsl:apply-templates select="BASE/CREATION_DATE" /></premis:dateCreatedByApplication>
					</xsl:if>
				</premis:creatingApplication>
			</xsl:if>
		</premis:objectCharacteristics>
	</premis:object>
</xsl:template>

</xsl:stylesheet>
#/bin/bash 

# Fido Server Info
FIDOSERVER_VERSION=4.7.0

# Server Passwords
MARIA_ROOT_PASSWORD=BigKahuna
MARIA_SKFSDBUSER_PASSWORD=AbracaDabra

XMXSIZE=512m
BUFFERPOOLSIZE=512m

# SSO
USE_DEFAULT_KEYS=N # Setting this flag to 'Y' will skip JWT and SAML key generation, instead using the default keys found in the SKFS distribution

# JWT
RPID=strongkey.com
JWT_CREATE=true
JWT_DURATION=30
JWT_DN='CN=StrongKey KeyAppliance,O=StrongKey'
JWT_KEYGEN_DN='/C=US/ST=California/L=Cupertino/O=StrongAuth/OU=Engineering'
JWT_CERTS_PER_SERVER=3
JWT_KEYSTORE_PASS=Abcd1234!
JWT_KEY_VALIDITY=365

# SAML
SAML_RESPONSE=false
SAML_CITRIX=false
SAML_DURATION=15
SAML_KEYGEN_DN='/C=US/ST=California/L=Cupertino/O=StrongAuth/OU=Engineering'
SAML_CERTS_PER_SERVER=3
SAML_TIMEZONE=UTC
SAML_KEYSTORE_PASS=Abcd1234!
SAML_KEY_VALIDITY=365

# MDS
MDS_ENABLED=true        # Property that enables MDS download
MDS_RETURN=false        # Property to determine if MDS data should be returned in the JSON response.
MDS_RETURN_WS=R,A,G
MDS_MECHANISM=url                               	# Property that define the MDS fetch mechanism. Allowed options : URL / File
MDS_MECHANISM_URL=https://mds.fidoalliance.org/         # In case of 'file' the location can be a file on the local file system under the /usr/local/strongauth directory
MDS_ROOTCA_URL=http://secure.globalsign.com/cacert/root-r3.crt

# RESPONSE_DETAIL
RESPONSE_DETAIL=false			# Property to determine if webservices should return detailed information in response.
RESPONSE_DETAIL_WEBSERVICES=R,A		# Property to determine what webservices should return the detailed information. Default : R,A ( Reg / Auth ). Comma separated list of all the allowed web services example : R, or R,A or A and so on.
RESPONSE_DETAIL_FORMAT=default		# Property to determine the format for the returned response details. Allowed values : default | webauthn2

# Policy
POLICY_DOMAINS=ALL	# 'ALL' or 'ONE'

ALLOW_USERNAME_CHANGE=false

#!/bin/bash

# Load libraries
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libmariadbgalera.sh

JWT_CERTS_PER_SERVER=3
JWT_DN='CN=StrongKey KeyAppliance,O=StrongKey'
JWT_DURATION=30
JWT_KEY_VALIDITY=365
POLICY_DOMAINS=ALL	
RPID=strongkey.com

set -eux
if is_boolean_yes "$(get_galera_cluster_bootstrap_value)"; then
    wait_for_mysql_access "$DB_ROOT_USER"
    cd /tmp/fido2server
    mysql_execute "$DB_DATABASE" "$DB_ROOT_USER" "$DB_ROOT_PASSWORD" --quick < create.txt

    echo "insert into SERVERS values (1, '$(hostname)', 'Active', 'Both', 'Active', null, null);" > server.sql
	echo "insert into DOMAINS values (1,'SKFS 1','Active','Active','-----BEGIN CERTIFICATE-----\nMIIDizCCAnOgAwIBAgIENIYcAzANBgkqhkiG9w0BAQsFADBuMRcwFQYDVQQKEw5T\ndHJvbmdBdXRoIEluYzEjMCEGA1UECxMaU0tDRSBTaWduaW5nIENlcnRpZmljYXRl\nIDExEzARBgNVBAsTClNBS0EgRElEIDExGTAXBgNVBAMTEFNLQ0UgU2lnbmluZyBL\nZXkwHhcNMTkwMTMwMjI1NDAwWhcNMTkwNDMwMjI1NDAwWjBuMRcwFQYDVQQKEw5T\ndHJvbmdBdXRoIEluYzEjMCEGA1UECxMaU0tDRSBTaWduaW5nIENlcnRpZmljYXRl\nIDExEzARBgNVBAsTClNBS0EgRElEIDExGTAXBgNVBAMTEFNLQ0UgU2lnbmluZyBL\nZXkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCH/W7ERX0U3a+2VLBY\nyjpCRTCdRtiuiLv+C1j64gLAyseF5sMH+tLNcqU0WgdZ3uQxb2+nl2y8Cp0B8Cs9\nvQi9V9CIC7zvMvgveQ711JqX8RMsaGBrn+pWx61E4B1kLCYCPSI48Crm/xkMydGM\nTKXHpfb+t9uo/uat/ykRrel5f6F764oo0o1KJkY6DjFEMh9TKMbJIeF127S2pFxl\nNNBhawTDGDaA1ag9GoWHGCWZ/bbCMMiwcH6q71AqRg8qby1EsBKA7E4DD8f+5X6b\nU3zcY3kudKlYxP4rix42PHCY3B4ZnpWS3A6lZRBot7NklsLvlxvDbKIiTcyDvSA0\nunfpAgMBAAGjMTAvMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQUlSKnwxvmv8Bh\nlkFSMeEtAM7AyakwDQYJKoZIhvcNAQELBQADggEBAG2nosn6cTsZTdwRGws61fhP\n+tvSZXpE5mYk93x9FTnApbbsHJk1grWbC2psYxzuY1nYTqE48ORPngr3cHcNX0qZ\npi9JQ/eh7AaCLQcb1pxl+fJAjnnHKCKpicyTvmupv6c97IE4wa2KoYCJ4BdnJPnY\nnmnePPqDvjnAhuCTaxSRz59m7aW4Tyt9VPsoBShrCSBYzK5cH3FNIGffqB7zI3Jh\nXo0WpVD/YBE/OsWRbthZ0OquJIfxcpdXS4srCFocQlqNMhlQ7ZVOs73WrRx+uGIr\nhUYvIJrqgAc7+F0I7v2nAQLmxMBYheZDhN9DA9LuJRV93A8ELIX338DKxBKBPPU=\n-----END CERTIFICATE-----',NULL,'-----BEGIN CERTIFICATE-----\nMIIDizCCAnOgAwIBAgIENIYcAzANBgkqhkiG9w0BAQsFADBuMRcwFQYDVQQKEw5T\ndHJvbmdBdXRoIEluYzEjMCEGA1UECxMaU0tDRSBTaWduaW5nIENlcnRpZmljYXRl\nIDExEzARBgNVBAsTClNBS0EgRElEIDExGTAXBgNVBAMTEFNLQ0UgU2lnbmluZyBL\nZXkwHhcNMTkwMTMwMjI1NDAwWhcNMTkwNDMwMjI1NDAwWjBuMRcwFQYDVQQKEw5T\ndHJvbmdBdXRoIEluYzEjMCEGA1UECxMaU0tDRSBTaWduaW5nIENlcnRpZmljYXRl\nIDExEzARBgNVBAsTClNBS0EgRElEIDExGTAXBgNVBAMTEFNLQ0UgU2lnbmluZyBL\nZXkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCH/W7ERX0U3a+2VLBY\nyjpCRTCdRtiuiLv+C1j64gLAyseF5sMH+tLNcqU0WgdZ3uQxb2+nl2y8Cp0B8Cs9\nvQi9V9CIC7zvMvgveQ711JqX8RMsaGBrn+pWx61E4B1kLCYCPSI48Crm/xkMydGM\nTKXHpfb+t9uo/uat/ykRrel5f6F764oo0o1KJkY6DjFEMh9TKMbJIeF127S2pFxl\nNNBhawTDGDaA1ag9GoWHGCWZ/bbCMMiwcH6q71AqRg8qby1EsBKA7E4DD8f+5X6b\nU3zcY3kudKlYxP4rix42PHCY3B4ZnpWS3A6lZRBot7NklsLvlxvDbKIiTcyDvSA0\nunfpAgMBAAGjMTAvMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQUlSKnwxvmv8Bh\nlkFSMeEtAM7AyakwDQYJKoZIhvcNAQELBQADggEBAG2nosn6cTsZTdwRGws61fhP\n+tvSZXpE5mYk93x9FTnApbbsHJk1grWbC2psYxzuY1nYTqE48ORPngr3cHcNX0qZ\npi9JQ/eh7AaCLQcb1pxl+fJAjnnHKCKpicyTvmupv6c97IE4wa2KoYCJ4BdnJPnY\nnmnePPqDvjnAhuCTaxSRz59m7aW4Tyt9VPsoBShrCSBYzK5cH3FNIGffqB7zI3Jh\nXo0WpVD/YBE/OsWRbthZ0OquJIfxcpdXS4srCFocQlqNMhlQ7ZVOs73WrRx+uGIr\nhUYvIJrqgAc7+F0I7v2nAQLmxMBYheZDhN9DA9LuJRV93A8ELIX338DKxBKBPPU=\n-----END CERTIFICATE-----',NULL,'CN=SKFS Signing Key,OU=DID 1,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
    # Insert policies. If POLICY_DOMAINS=ALL (Default: ALL), then 8 domains with different policies will be added.
	startDate=$(date +%s)
	fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"MinimalPolicy\",\"copyright\":\"\",\"version\":\"1.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":false,\"userVerification\":[\"required\",\"preferred\",\"discouraged\"],\"userPresenceTimeout\":0,\"allowedAaguids\":[\"all\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"RS256\",\"RS384\",\"RS512\",\"PS256\",\"PS384\",\"PS384\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"none\",\"indirect\",\"direct\",\"enterprise\"],\"formats\":[\"fido-u2f\",\"packed\",\"tpm\",\"android-key\",\"android-safetynet\",\"apple\",\"none\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\",\"cross-platform\"],\"discoverableCredential\":[\"required\",\"preferred\",\"discouraged\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
	echo "insert into FIDO_POLICIES values (1,1,1,'${fidoPolicy}','Active','',NOW(),NULL,NULL);" >> server.sql

	if [ ${POLICY_DOMAINS^^} = "ALL" ]; then
		# Domain 2
		echo "insert into DOMAINS values (2,'SKFS 2','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 2,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"ModerateSKFSPolicy-SpecificSecurityKeys\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"preferred\"],\"userPresenceTimeout\":60,\"allowedAaguids\":[\"95442b2e-f15e-4def-b270-efb106facb4e\",\"87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c\",\"95442b2e-f15e-4def-b270-efb106facb4e\",\"87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c\",\"da776f39-f6c8-4a89-b252-1d86137a46ba\",\"e3512a8a-62ae-11ea-bc55-0242ac130003\",\"cb69481e-8ff7-4039-93ec-0a2729a154a8\",\"ee882879-721c-4913-9775-3dfcce97072a\",\"fa2b99dc-9e39-4257-8f92-4a30d23c4118\",\"2fc0579f-8113-47ea-b116-bb5a8db9202a\",\"c1f9a0bc-1dd2-404a-b27f-8e29047a43fd\",\"cb69481e-8ff7-4039-93ec-0a2729a154a8\",\"ee882879-721c-4913-9775-3dfcce97072a\",\"73bb0cd4-e502-49b8-9c6f-b59445bf720b\",\"cb69481e-8ff7-4039-93ec-0a2729a154a8\",\"ee882879-721c-4913-9775-3dfcce97072a\",\"73bb0cd4-e502-49b8-9c6f-b59445bf720b\",\"cb69481e-8ff7-4039-93ec-0a2729a154a8\",\"ee882879-721c-4913-9775-3dfcce97072a\",\"73bb0cd4-e502-49b8-9c6f-b59445bf720b\",\"2fc0579f-8113-47ea-b116-bb5a8db9202a\",\"c1f9a0bc-1dd2-404a-b27f-8e29047a43fd\",\"c5ef55ff-ad9a-4b9f-b580-adebafe026d0\",\"85203421-48f9-4355-9bc8-8a53846e5083\",\"f8a011f3-8c0a-4d15-8006-17111f9edc7d\",\"b92c3f9a-c014-4056-887f-140a2501163b\",\"6d44ba9b-f6ec-2e49-b930-0c8fe920cb73\",\"149a2021-8ef6-4133-96b8-81f8d5b7f1f5\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"packed\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"cross-platform\"],\"discoverableCredential\":[\"preferred\",\"discouraged\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,2,2,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 3
		echo "insert into DOMAINS values (3,'SKFS 3','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 3,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"SecureSKFSPolicy-AllBiometricDevices\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"all\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"packed\",\"tpm\",\"android-key\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\",\"cross-platform\"],\"discoverableCredential\":[\"required\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,3,3,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 4
		echo "insert into DOMAINS values (4,'SKFS 4','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 4,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"RestrictedSKFSPolicy-Android-SafetyNet\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"b93fd961-f2e6-462f-b122-82002247de78\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"android-safetynet\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\"],\"discoverableCredential\":[\"required\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,4,4,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 5
		echo "insert into DOMAINS values (5,'SKFS 5','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 5,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"RestrictedSKFSPolicy-TPM\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"08987058-cadc-4b81-b6e1-30de50dcbe96\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"RS256\",\"RS384\",\"RS512\",\"PS256\",\"PS384\",\"PS384\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"tpm\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\"],\"discoverableCredential\":[\"required\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,5,5,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 6
		echo "insert into DOMAINS values (6,'SKFS 6','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 6,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"RestrictedSKFSPolicy-Android-Key\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"b93fd961-f2e6-462f-b122-82002247de78\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"android-key\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\"],\"discoverableCredential\":[\"required\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{\"uvm\":{\"allowedMethods\":[\"presence\",\"fingerprint\",\"passcode\",\"voiceprint\",\"faceprint\",\"eyeprint\",\"pattern\",\"handprint\"],\"allowedKeyProtections\":[\"hardware\",\"secureElement\"],\"allowedProtectionTypes\":[\"tee\",\"chip\"]}},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,6,6,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 7
		echo "insert into DOMAINS values (7,'SKFS 7','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 7,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"RestrictedSKFSPolicy-Apple\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"optional\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"all\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"apple\",\"none\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"platform\"],\"discoverableCredential\":[\"required\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"$(hostname)\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,7,7,'${fidoPolicy}','Active','',NOW(),NULL,NULL);"
		# Domain 8
		echo "insert into DOMAINS values (8,'SKFS 8','Active','Active','',NULL,'',NULL,'CN=SKFS Signing Key,OU=DID 8,OU=SKFS EC Signing Certificate 1,O=StrongKey','https://$(hostname):8181/app.json',NULL);" >> server.sql
		fidoPolicy=$(echo "{\"FidoPolicy\":{\"name\":\"RestrictedSKFSPolicy-FIPS\",\"copyright\":\"StrongAuth, Inc. (DBA StrongKey) All Rights Reserved\",\"version\":\"2.0\",\"startDate\":\"${startDate}\",\"endDate\":\"1760103870871\",\"system\":{\"requireCounter\":\"mandatory\",\"integritySignatures\":true,\"userVerification\":[\"required\"],\"userPresenceTimeout\":30,\"allowedAaguids\":[\"c1f9a0bc-1dd2-404a-b27f-8e29047a43fd\"],\"jwtKeyValidity\":${JWT_KEY_VALIDITY},\"jwtRenewalWindow\":30,\"transport\":[\"usb\",\"internal\"]},\"algorithms\":{\"curves\":[\"secp256r1\",\"secp384r1\",\"secp521r1\",\"curve25519\"],\"rsa\":[\"none\"],\"signatures\":[\"ES256\",\"ES384\",\"ES512\",\"EdDSA\",\"ES256K\"]},\"attestation\":{\"conveyance\":[\"direct\"],\"formats\":[\"packed\"]},\"registration\":{\"displayName\":\"required\",\"attachment\":[\"cross-platform\"],\"discoverableCredential\":[\"required\",\"preferred\",\"discouraged\"],\"excludeCredentials\":\"enabled\"},\"authentication\":{\"allowCredentials\":\"enabled\"},\"authorization\":{\"maxdataLength\":256,\"preserve\":true},\"rp\":{\"id\":\"${RPID}\",\"name\":\"FIDOServer\"},\"extensions\":{},\"mds\":{\"authenticatorStatusReport\":[{\"status\":\"FIDO_CERTIFIED_L1\",\"priority\":\"1\",\"decision\":\"IGNORE\"},{\"status\":\"FIDO_CERTIFIED_L2\",\"priority\":\"1\",\"decision\":\"ACCEPT\"},{\"status\":\"UPDATE_AVAILABLE\",\"priority\":\"5\",\"decision\":\"IGNORE\"},{\"status\":\"REVOKED\",\"priority\":\"10\",\"decision\":\"DENY\"}]},\"jwt\":{\"algorithms\":[\"ES256\",\"ES384\",\"ES521\"],\"duration\":${JWT_DURATION},\"required\":[\"rpid\",\"iat\",\"exp\",\"cip\",\"uname\",\"agent\"],\"signingCerts\":{\"DN\":\"${JWT_DN}\",\"certsPerServer\":${JWT_CERTS_PER_SERVER}}}}}" | /usr/bin/base64 -w 0) >> server.sql
		echo "insert into FIDO_POLICIES values (1,8,8,'${fidoPolicy}','Active','',NOW(),NULL,NULL);" >> server.sql
	fi
    mysql_execute "$DB_DATABASE" "$DB_ROOT_USER" "$DB_ROOT_PASSWORD" < server.sql
fi

set +eux
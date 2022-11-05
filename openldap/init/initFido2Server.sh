#!/bin/bash

# Load libraries
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libopenldap.sh

# Everything else
ldap_start_bg

SAKA_DID=1
SERVICE_LDAP_SVCUSER_PASS=Abcd1234!
set -eu
debug_execute ldapadd -f "/tmp/fido2server/skfs-base.ldif" -H "ldapi:///" -D "$LDAP_ADMIN_DN" -w "$LDAP_ADMIN_PASSWORD"

SLDNAME=${LDAP_ROOT%%,dc*}
sed -r "s|dc=strongauth,dc=com|$LDAP_ROOT|
    s|dc: strongauth|dc: ${SLDNAME#dc=}|
    s|did: .*|did: ${SAKA_DID}|
    s|did=[0-9]+,|did=${SAKA_DID},|
    s|^ou: [0-9]+|ou: ${SAKA_DID}|
    s|(domain( id)*) [0-9]*|\1 ${SAKA_DID}|
    s|userPassword: .*|userPassword: $SERVICE_LDAP_SVCUSER_PASS|" /tmp/fido2server/skfs.ldif > /tmp/skfs.ldif

debug_execute ldapadd -f /tmp/skfs.ldif -H "ldapi:///" -D "$LDAP_ADMIN_DN" -w "$LDAP_ADMIN_PASSWORD"

debug_execute ldapmodify -f /tmp/fido2server/add_slapdlog.ldif -H "ldapi:///" -Y EXTERNAL

set +eu
ldap_stop
FROM darkedges/fido2server_base as f2s_base

FROM bitnami/openldap:latest

COPY init/ /docker-entrypoint-initdb.d/
COPY --chown=1001:1001 --from=f2s_base /tmp/fido2server/*.ldif /tmp/fido2server/
COPY --chown=1001:1001 --from=f2s_base /tmp/fido2server/10-slapd.conf /etc/rsyslog.d/10-slapd.conf

HEALTHCHECK CMD ldapsearch -H ldap://127.0.0.1:1389 -D cn=${LDAP_ADMIN_USERNAME},${LDAP_ROOT} -w ${LDAP_ADMIN_PASSWORD} -b ${LDAP_ROOT} "uid=skceadmin"
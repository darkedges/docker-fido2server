FROM darkedges/fido2server_base as f2s_base

FROM bitnami/openldap:latest

COPY --from=f2s_base /tmp/fido2server/*.ldif /tmp/ldif/
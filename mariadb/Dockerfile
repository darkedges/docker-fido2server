FROM darkedges/fido2server_base as f2s_base

FROM bitnami/mariadb-galera:latest

COPY init/ /docker-entrypoint-initdb.d/
COPY --chown=1001:1001 --from=f2s_base /tmp/fido2server/fidoserverSQL/ /tmp/fido2server/

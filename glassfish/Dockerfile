FROM darkedges/fido2server_base as f2s_base

FROM payara/server-full:5.2022.2-jdk11

ENV STRONGKEY_HOME=/usr/local/strongkey \
    SKFS_SOFTWARE=/tmp/fido2server \
    GLASSFISH_CONFIG=/opt/payara/appserver/glassfish/domains/domain1/config
ENV SKFS_HOME=${STRONGKEY_HOME}/skfs

USER root
ADD https://downloads.mariadb.com/Connectors/java/connector-java-2.2.6/mariadb-java-client-2.2.6.jar /opt/payara/appserver/glassfish/lib/mariadb-java-client-2.2.6.jar
RUN chown payara:payara /opt/payara/appserver/glassfish/lib/mariadb-java-client-2.2.6.jar  && \
    chmod 0644 /opt/payara/appserver/glassfish/lib/mariadb-java-client-2.2.6.jar && \
    mkdir -p mkdir -p $STRONGKEY_HOME/certs $STRONGKEY_HOME/Desktop $STRONGKEY_HOME/dbdumps $STRONGKEY_HOME/lib $STRONGKEY_HOME/bin $STRONGKEY_HOME/appliance/etc $STRONGKEY_HOME/crypto/etc $SKFS_HOME/etc $SKFS_HOME/keystores $STRONGKEY_HOME/skce/etc/ $STRONGKEY_HOME/fido && \
    chown -R payara:payara /usr/local/strongkey 

USER payara
COPY --chown=payara:payara --from=f2s_base $SKFS_SOFTWARE/ $SKFS_SOFTWARE/
COPY --from=f2s_base --chown=payara:payara $SKFS_SOFTWARE/fidoserver.ear $DEPLOY_DIR
COPY scripts/ /usr/local/strongkey/scripts

RUN /usr/local/strongkey/scripts/build.sh

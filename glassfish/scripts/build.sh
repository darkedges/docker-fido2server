#/bin/bash -eux

. /usr/local/strongkey/scripts/env.sh

mv $SKFS_SOFTWARE/certimport.sh $STRONGKEY_HOME/bin 
mv $SKFS_SOFTWARE/signingkeystore.bcfks $SKFS_SOFTWARE/signingtruststore.bcfks $SKFS_HOME/keystores 
mv $SKFS_SOFTWARE/keymanager $STRONGKEY_HOME 
mv $SKFS_SOFTWARE/skfsclient $STRONGKEY_HOME

keytool -genkeypair -alias skfs -keystore $GLASSFISH_CONFIG/keystore.jks -storepass changeit -keypass changeit -keyalg RSA -keysize 2048 -sigalg SHA256withRSA -validity 3562 -dname "CN=$(hostname),OU=\"StrongKey FidoServer\""  
keytool -changealias -alias s1as -destalias s1as.original -keystore $GLASSFISH_CONFIG/keystore.jks -storepass changeit  
keytool -changealias -alias skfs -destalias s1as -keystore $GLASSFISH_CONFIG/keystore.jks -storepass changeit  
keytool -exportcert -alias s1as -file $STRONGKEY_HOME/certs/$(hostname).der --keystore $GLASSFISH_CONFIG/keystore.jks -storepass changeit  
keytool -importcert -noprompt -alias $(hostname) -file $STRONGKEY_HOME/certs/$(hostname).der --keystore $STRONGKEY_HOME/certs/cacerts -storepass changeit   
keytool -importcert -noprompt -alias $(hostname) -file $STRONGKEY_HOME/certs/$(hostname).der --keystore $GLASSFISH_CONFIG/cacerts.jks -storepass changeit 

cat << EOF > $STRONGKEY_HOME/crypto/etc/crypto-configuration.properties 
crypto.cfg.property.jwtsigning.certsperserver=$JWT_CERTS_PER_SERVER
EOF

cat << EOF > $STRONGKEY_HOME/appliance/etc/appliance-configuration.properties 
appliance.cfg.property.serverid=1
appliance.cfg.property.enableddomains.ccspin=$CCS_DOMAINS
appliance.cfg.property.replicate=false
EOF

cat << EOF > $STRONGKEY_HOME/skfs/etc/skfs-configuration.properties
skfs.cfg.property.allow.changeusername=$ALLOW_USERNAME_CHANGE
skfs.cfg.property.jwt.create=$JWT_CREATE
skfs.cfg.property.saml.response=$SAML_RESPONSE
skfs.cfg.property.saml.certsperserver=$SAML_CERTS_PER_SERVER
skfs.cfg.property.saml.timezone=$SAML_TIMEZONE
skfs.cfg.property.saml.citrix=$SAML_CITRIX
skfs.cfg.property.saml.assertion.duration=$SAML_DURATION
skfs.cfg.property.saml.issuer.entity.name=https://$(hostname)/
skfs.cfg.property.mds.enabled=$MDS_ENABLED
skfs.cfg.property.return.MDS=$MDS_RETURN
skfs.cfg.property.return.MDS.webservices=$MDS_RETURN_WS
skfs.cfg.property.mds.mechanism=$MDS_MECHANISM
skfs.cfg.property.mds.url=$MDS_MECHANISM_URL
skfs.cfg.property.mds.rootca.url=$MDS_ROOTCA_URL
skfs.cfg.property.apple.rootca.url=$STRONGKEY_HOME/skfs/applerootca.crt
skfs.cfg.property.return.responsedetail=$RESPONSE_DETAIL
skfs.cfg.property.return.responsedetail.webservices=$RESPONSE_DETAIL_WEBSERVICES
skfs.cfg.property.return.responsedetail.format=$RESPONSE_DETAIL_FORMAT
EOF

touch $STRONGKEY_HOME/fido/VersionFidoServer-$FIDOSERVER_VERSION

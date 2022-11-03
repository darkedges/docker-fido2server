# fido2server

```console
docker compose up
docker compose down
docker volume rm fido2server_mariadb_data fido2server_openldap_data
```

## openldap

```console
docker run -it --rm --name openldap-client --network fido2server_f2s  bitnami/openldap ldapsearch -Hldap://openldap:1389 -Dcn=admin,dc=example,dc=org -wadminpassword  -b dc=example,dc=org "(objectclass=*)"
```

## mariadb

```console
docker run -it --rm --name mariadb-client --network fido2server_f2s  bitnami/mariadb-galera:latest mysql -h mariadb -u mariadb -D customdatabase -padminpassword
 ```

# IAM DEMO

This demonstration showcase the usage of `dex` and `keycloak-gatekeeper`
to filter acces to a legacy application using an OIDC aware reverse proxy.

The demonstration contains:
- An [OpenLDAP](https://www.openldap.org/) server

Provides the identity referential, it contains an `admin` user that belong to the 
`admin.roles.demo.iam` group and a `dex` user who is member of `readonly.roles.demo.iam`. This group is given the full LDAP tree readonly access.

- [Dex](https://github.com/dexidp/dex)

Provides OIDC and OAuth 2.0 using the LDAP server as backend to authenticate users.

- [Keycloak Gatekeeper](https://github.com/keycloak/keycloak-gatekeeper)

Restrict access to the application `/private/*`, based on the authenticated user `groups` membership. 

- A python web server

Simple HTTP web server, serve all it's contents without restrictions.

## Requirements

- `docker` installed 
- `docker-compose` installed
- (optionnal) `make`


You need to make sure that `app.lan` and `idp.lan` both resolves to your target machine.
This is a requirement of the identity provider.

For local testing, you can add this record to your `/etc/hosts` file:
```
127.0.0.1 idp.lan app.lan
```

## Usage

1. run `make up`
2. Navigate to [http://app.lan](http://app.lan)
3. Credentials for the private page are `admin:password`


When you are done, you can delete all the containers and networks with `make clean`.


## Troubleshoot

- Access denied without authentication form

As Dex use a development configuration, it does not recognise signed tokens after an application restart. Your browser however, keep the cookies until the token expires, you will need to clean all `app.lan` local storage or open a private navigation session. 
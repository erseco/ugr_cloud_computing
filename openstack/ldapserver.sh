#!/bin/bash

# apt-get --purge remove slapd ldap-utils
apt-get install slapd ldap-utils

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif;\
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif;\
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/nis.ldif

echo 'insert your domain name (ex: dc=home,dc=com): '

read -e domain

passChecked=0
while [ $passChecked -eq 0 ]
do
echo "insert password for user admin:"
read -es pass
echo "repeat password for user admin:"
read -es passControl

echo $pass
echo $passControl
if [ $pass = $passControl ];then
passChecked=1
else
echo "passwords don't match"
fi
done

echo "################################################# ##########
# DATABASE SETUP
################################################## #########

# Load modules for database type
dn: cn=module{0},cn=config
objectClass: olcModuleList
cn: module{0}
olcModulePath: /usr/lib/ldap
olcModuleLoad: {0}back_hdb

# Create directory database
dn: olcDatabase={1}hdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcHdbConfig
olcDatabase: {1}hdb
olcDbDirectory: /var/lib/ldap
olcSuffix: $domain
olcRootDN: cn=admin,$domain
olcRootPW: $pass
olcAccess: {0}to attrs=userPassword,shadowLastChange by dn=\"cn=admin,$domain\" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn=\"cn=admin,$domain\" write by * read
olcLastMod: TRUE
olcDbCheckpoint: 512 30
olcDbConfig: {0}set_cachesize 0 2097152 0
olcDbConfig: {1}set_lk_max_objects 1500
olcDbConfig: {2}set_lk_max_locks 1500
olcDbConfig: {3}set_lk_max_lockers 1500
olcDbIndex: uid pres,eq
olcDbIndex: cn,sn,mail pres,eq,approx,sub
olcDbIndex: objectClass eq


################################################## #########
# DEFAULTS MODIFICATION
################################################## #########
# Some of the defaults need to be modified in order to allow
# remote access to the LDAP config. Otherwise only root
# will have administrative access.

dn: cn=config
changetype: modify
delete: olcAuthzRegexp

dn: olcDatabase={-1}frontend,cn=config
changetype: modify
delete: olcAccess

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: `slappasswd -s $pass`

dn: olcDatabase={0}config,cn=config
changetype: modify
delete: olcAccess" > conf.ldif

echo
ldapadd -Y EXTERNAL -H ldapi:/// -f conf.ldif

domainmod=(`echo $domain | sed -e "s/\,//g"`)
domainmod=(`echo $domainmod | sed -e "s/\dc//g"`)
domainarray=(`echo $domainmod | tr '=' ' '`)

echo "# Tree root
dn: $domain
objectClass: dcObject
objectclass: organization
o: ${domainarray[0]}.${domainarray[1]}
dc: ${domainarray[0]}
description: Tree root

# LDAP admin
dn: cn=admin,$domain
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
userPassword: $pass
description: LDAP administrator" > base.ldif

ldapadd -x -D cn=admin,$domain -W -f base.ldif
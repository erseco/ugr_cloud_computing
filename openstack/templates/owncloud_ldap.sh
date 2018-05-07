#!/bin/bash

LDAP_SERVER={{database}}


value=$(PGPASSWORD=$OWNCLOUD_DB_PASSWORD psql -U $OWNCLOUD_DB_USERNAME -h {{database}} $OWNCLOUD_DB_NAME -tAc "SELECT COUNT(*) FROM oc_appconfig WHERE appid = 'user_ldap' AND configkey LIKE 's01%';")

if [[ $value == "0" ]]; then


# Enable ldap plugin (better do it in env vars)
# su www-data -c "php occ app:enable user_ldap -n -q --no-ansi

# Enable and configure LDAP and external storage plugin
occ ldap:create-empty-config -n -q --no-ansi
occ ldap:set-config 's01' ldapBase dc=example,dc=com -n -q --no-ansi
occ ldap:set-config 's01' ldapBaseGroups dc=example,dc=com -n -q --no-ansi
occ ldap:set-config 's01' ldapBaseUsers dc=example,dc=com -n -q --no-ansi
occ ldap:set-config 's01' ldapCacheTTL 600 -n -q --no-ansi
occ ldap:set-config 's01' ldapConfigurationActive 1 -n -q --no-ansi
occ ldap:set-config 's01' ldapEmailAttribute mail -n -q --no-ansi
occ ldap:set-config 's01' ldapExperiencedAdmin 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapExpertUsernameAttr uid -n -q --no-ansi
occ ldap:set-config 's01' ldapGroupDisplayName cn -n -q --no-ansi
occ ldap:set-config 's01' ldapGroupFilter objectClass=posixGroup -n -q --no-ansi
occ ldap:set-config 's01' ldapGroupFilterMode 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapGroupMemberAssocAttr uniqueMember -n -q --no-ansi
occ ldap:set-config 's01' ldapHost ${LDAP_SERVER} -n -q --no-ansi
occ ldap:set-config 's01' ldapLoginFilter '(&(|(objectclass=posixAccount))(uid=%uid))' -n -q --no-ansi
occ ldap:set-config 's01' ldapLoginFilterEmail 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapLoginFilterMode 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapLoginFilterUsername 1 -n -q --no-ansi
occ ldap:set-config 's01' ldapNestedGroups 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapPagingSize 500 -n -q --no-ansi
occ ldap:set-config 's01' ldapPort 389 -n -q --no-ansi
occ ldap:set-config 's01' ldapQuotaAttribute mailQuota -n -q --no-ansi
occ ldap:set-config 's01' ldapTLS 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapUserDisplayName cn -n -q --no-ansi
occ ldap:set-config 's01' ldapUserFilter objectClass=posixAccount -n -q --no-ansi
occ ldap:set-config 's01' ldapUserFilterMode 0 -n -q --no-ansi
occ ldap:set-config 's01' ldapUuidGroupAttribute auto -n -q --no-ansi
occ ldap:set-config 's01' ldapUuidUserAttribute auto -n -q --no-ansi

fi

/container/tool/run --copy-service -l debug &

sleep 5

cat | ldapmodify -H ldapi:// -Y EXTERNAL <<EOF

# Delete default ACL entry

dn: olcDatabase={1}mdb,cn=config
changetype: modify
delete: olcAccess
olcAccess: to * by self read by dn="cn=admin,dc=demo,dc=iam" write by * none


# Add admin group members LDAP write permissions
# Add full subtree read to readonly group members

dn: olcDatabase={1}mdb,cn=config
changetype: modify
add: olcAccess
olcAccess: 
    to dn.subtree="dc=demo,dc=iam" 
    by self write 
    by group.exact="cn=admin,ou=roles,dc=demo,dc=iam" write 
    by group.exact="cn=readonly,ou=roles,dc=demo,dc=iam" read 
    by * none

EOF

wait
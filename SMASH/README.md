
# SMASH Quick Ref
<br>

### Prereqs

SMASH relies on:  
o PostgreSQL: library & server  
o cardano-db-node   
o cardano-db-sync or cardano-db-sync-extended  
<br>

### Install

o Clone at the same level of node & db  
```
git clone https://github.com/input-output-hk/smash
cd smash
nix-build -o smash-local 
```
<br>

### Base config  

o Create schema at smash/config/pgpass (should already be there)
```
/var/run/postgresql:5432:smash:*:*
```  

o Create db from script
```
SMASHPGPASSFILE=config/pgpass ./scripts/postgresql-setup.sh --createdb
```  

o Run/create migrations (if any).
```
SMASHPGPASSFILE=config/pgpass smash-local-2/bin/smash-exe \
--create-migrations \
--mdir /schema
```
```
SMASHPGPASSFILE=config/pgpass smash-local-2/bin/smash-exe \
--run-migrations \
--mdir /schema
```
<br>

### Run server
o Without previous db, will take time to catch up with the relevant data
on Shelley chain - somewhere around block 4,000,000.  
```
SMASHPGPASSFILE=config/pgpass smash-local-2/bin/smash-exe \
--run-app-with-db-sync \
--config config/mainnet-config.yaml \
--socket-path ../cardano-node/state-node-mainnet/node.socket \
--schema-dir schema/
```
<br>

### Backup & restore
See PostgreSQL entry

<br><br>


### Add http api functionality

o Install http server (e.g. Apache)  

o Enable Basic Auth flag - then at the psql server. This will enable SMASH
server to run with user authentication from the db.  
```
INSERT INTO admin_user (username, password) VALUES ('jimmy', 'test');
```

o Run the server  
```
SMASHPGPASSFILE=config/pgpass smash-local-2/bin/smash-exe -- run-app
```

o Services are now available through curl at ` http://localhost:3100 ` e.g.  
```
curl -X GET -v http://localhost:3100/api/v1/metadata/062693863e0bcf9f619238f020741381d4d3748aae6faf1c012e80e7/cbdfc4f21feb0a414b2b9471fa56b0ebd312825e63db776d68cc3fa0ca1f5a2f | jq
```

o Get the Swagger/OpenAPI info - copy localhost contents into the swagger editor  
```
http://localhost:3000/swagger.json  
----------
https://editor.swagger.io/
```


<br><br>


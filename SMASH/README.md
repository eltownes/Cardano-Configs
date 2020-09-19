
# SMASH Quick Ref

### Prereqs

SMASH relies on:  

* PostgreSQL: library & server  
* cardano-db-node   
* cardano-db-sync or cardano-db-sync-extended  

### Install

* Clone at the same level of node & db  
```
git clone https://github.com/input-output-hk/smash  

cd smash  

nix-build -o smash-local 
```

### Base config  

* Create schema at smash/config/pgpass (should already be there)
```
/var/run/postgresql:5432:smash:*:*
```  

* Create db from script
```
SMASHPGPASSFILE=config/pgpass ./scripts/postgresql-setup.sh --createdb
```  

* Run/create migrations (if any).
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

### Run server
* Without previous db, will take time to catch up with the relevant data
on Shelley chain - somewhere around block 4,000,000.  
```
SMASHPGPASSFILE=config/pgpass smash-local-2/bin/smash-exe \
--run-app-with-db-sync \
--config config/mainnet-config.yaml \
--socket-path ../cardano-node/state-node-mainnet/node.socket \
--schema-dir schema/
```

### Backup & restore
See PostgreSQL Quick Ref


<br><br>


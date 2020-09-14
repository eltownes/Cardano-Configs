
# SMASH Quick Ref

### Prereqs

SMASH relies on:  
o PostgreSQL: library & server  
o cardano-db-node   
o cardano-db-sync or cardano-db-sync-extended  

### Install

o Clone at the same level of node & db  
```
git clone https://github.com/input-output-hk/smash
cd smash
nix-build -o smash-local 
```

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

### Backup & restore
See PostgreSQL Quick Ref


<br><br>


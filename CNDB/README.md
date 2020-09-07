
# Node & db Quick Ref
<br>

### Prereqs
```
sudo apt update  

sudo apt install git  

sudo apt install curl  

sudo apt install postgresql postgresql-contrib  # (also check the Apt Repo)
```
<br>

### Install Nix
```
curl -L https://nixos.org/nix/install > install-nix.sh  

chmod +x install-nix.sh  

./install-nix.sh  

./home/mike/.nix-profile/etc/profile.d/nix.sh
```
<br>

### Set up a binary cache (speed up install)
```
sudo mkdir -p /etc/nix  

cat << EOF | sudo tee /etc/nix/nix.conf
substituters = https://cache.nixos.org https://hydra.iohk.io
trusted-public-keys = iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
EOF
```
<br>

### Clone & build node
```
git clone https://github.com/input-output-hk/cardano-node

cd cardano-node

nix-build -A scripts.mainnet.node -o mainnet-node-local
```
<br>

### Clone & build db
```
git clone https://github.com/input-output-hk/cardano-db-sync

cd cardano-db-sync

nix-build -A cardano-db-sync -o db-sync-node
   # or build extended
nix-build -A cardano-db-sync-extended -o db-sync-extended
```
<br>

### Config postgresql
Also check [postgreSQL notes](https://github.com/eltownes/Cardano-Configs/tree/master/PostgreSQL)
```
# from the db directory

scripts/postgresql-setup.sh --createdb

export PGPASSFILE=/home/mike/cardano-db-sync/config/pgpass

sudo -u postgres createuser --createdb --superuser jim
```
<br>

### Run node with db on 2 terminals
```
./mainnet-node-local

PGPASSFILE=config/pgpass db-sync-node/bin/cardano-db-sync \
 --config config/mainnet-config.yaml \
 --socket-path ../cardano-node/state-node-mainnet/node.socket \
 --schema-dir schema/

  # OR

PGPASSFILE=config/pgpass db-sync-extended/bin/cardano-db-sync-extended \
 --config config/mainnet-config.yaml \
 --socket-path ../cardano-node/state-node-mainnet/node.socket \
 --schema-dir schema/
```


<br><br>


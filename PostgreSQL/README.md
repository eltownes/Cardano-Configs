
# PostgreSQL Quick Ref
<br>


### Resources

o [PostgreSQL](https://www.postgresql.org/)  
  \  \  \ o [Apt Repo](https://www.postgresql.org/download/linux/ubuntu/)  
  \  \  \ o [Current docs](https://www.postgresql.org/docs/current/)  
o [DBeaver](https://dbeaver.io/)  
o [pgAdmin](https://www.pgadmin.org/)  
<br>

### TOC
o [Admin](#admin)  
o [Backup & Restore](#backup-and-restore)  
o [R and psql](#postgresql-with-r-from-windows)  
<br>

### Install
Get it from the Apt Repo  
<br>

### Magic
```
psql -i -u postgres
````
<br>

### Service  
o System & database (psql) & db admin tool may have tricky uid & pwd setup  
o Default folder: /etc/postgresql  
  \ \ \ \ o postgresql.conf - for network settings  
  \ \ \ \ o opg_hba.conf - for authentication settings  
  \ \ \ \ o pg_ident.conf - for identity mapping  
o Default logging folder: /var/log/postgresql  
o Default socket & host: /var/run/postgresql & 5432  
o ` psql -V ` : version -V not -v  
o ` netstat -nlt ` : display listening tcpip connections  
o ` service postgresql < status | start | stop | restart > `  
<br>

### Admin
#### Before login  
o ` psql -l ` : list databases  
o ` psql -d < database > ` : connect to database  
<br>

#### After login  
o ` \? ` : for psql help  
o ` \h ` : for SQL help  
o ` \l ` : list databases  
o ` \dn ` : list schemas  
o ` \du ` : list users  
o ` \dv ` : list views  
o ` \conninfo ` : display connection info  
  \ \ \ \ e.g. `You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".`  
o ` ALTER USER jim WITH PASSWORD 'jimmy'; `  
o ` \q ` : quit  
<br>

#### Views
o Create View from table1
```
CREATE VIEW public."viewTest" AS
 SELECT *
 FROM public.table1;
```
o Drop View
```
DROP VIEW "viewTest";
```
o Scripting
```
# First drop
psql --dbname=dbTest --command="DROP VIEW IF EXISTS public.\""C_Test\"";"

# Then create
psql --dbname=dbTest --command="
 CREATE VIEW public.\""C_Test\"" AS 
 SELECT * 
 FROM public.industry;
"
```
<br>

### Backup and restore
Multiple databases on same server

o Backup
```
pg_dumpall -F t > /tmp/backups/postgres/all_dbs.tar  
```
o Restore
```
pg_restore -d new_db /tmp/backups/postgres/all_dbs.tar -c -U postgres
```

<br>

### PostgreSQL with R from Windows
```
# PostgreSQL OR ODBC

# ODBC can (not always?) browse the database tables through the connections window

#
library(dplyr)
library(dbplyr)
library(DBI)
library(odbc)
library(RPostgreSQL)


# PSQL
con <- DBI::dbConnect(RPostgreSQL::PostgreSQL(),
          host = "1.1.1.1",
          dbname = "dbTest",
          port = 5432,
          user = rstudioapi::askForPassword("Database User"),
          password = rstudioapi::askForPassword("Database Password")
        )

# ODBC
# pick the driver
sort(unique(odbcListDrivers()[[1]]))
#
con <- dbConnect(odbc::odbc(),
        driver = "PostgreSQL Unicode(x64)",
        server = "1.1.1.1",
        port = 5432,
        database = "dbTest",
        uid = rstudioapi::askForPassword("Database User"),
        pwd = rstudioapi::askForPassword("Database Password")
        )
```


<br><br>


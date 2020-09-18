
# PostgreSQL Quick Ref

## Resources

* [PostgreSQL](https://www.postgresql.org/)
  * [Apt Repo](https://www.postgresql.org/download/linux/ubuntu/)
  * [Current docs](https://www.postgresql.org/docs/current/)
* [DBeaver](https://dbeaver.io/)
* [pgAdmin](https://www.pgadmin.org/)

## TOC
* [Admin](#admin)  
* [Views](#views)
* [Backup & Restore](#backup-and-restore)  
* [R and psql](#postgresql-with-r-from-windows)  

## Install
Get it from the Apt Repo  

## Magic
```
psql -i -u postgres
````

## Service  
* System & database (psql) & db admin tool may have tricky uid & pwd setup  
* Default folder: /etc/postgresql  
  * postgresql.conf - for network settings  
  * opg_hba.conf - for authentication settings  
  * pg_ident.conf - for identity mapping  
* Default logging folder: /var/log/postgresql  
* Default socket & host: /var/run/postgresql & 5432  
* ` psql -V ` : version -V not -v  
* ` netstat -nlt ` : display listening tcpip connections  
* ` service postgresql < status | start | stop | restart > `  

## Admin
#### Before login  
* ` psql -l ` : list databases  
* ` psql -d < database > ` : connect to database  

#### After login  
* ` \? ` : for psql help  
* ` \h ` : for SQL help  
* ` \l ` : list databases  
* ` \dn ` : list schemas  
* ` \du ` : list users  
* ` \dv ` : list views  
* ` \conninfo ` : display connection info  
  * e.g. `You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".`  
* ` ALTER USER jim WITH PASSWORD 'jimmy'; `  
* ` \q ` : quit  

#### Views
Best implemented through scripting - see [matViews.sh](matViews.sh)  

## Backup and restore

* Backup
```
pg_dump [db] -f $HOME/backup/[db]_backup.tar -F t -v
```
* Restore - first create db
```
pg_restore -d [db] $HOME/backup/[db]_backup.tar -F t -v -U [user]
```

## PostgreSQL with R from Windows
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


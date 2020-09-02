
# PostgreSQL Quick Ref
<br>

### Sources

* [PSQL](https://www.postgresql.org/)  
* [DBeaver](https://dbeaver.io/)  
* [pgAdmin](https://www.pgadmin.org/)  
<br>

### Magic
```
psql -i -u postgres
````
<br>

### Service  
* System & database (psql) & db admin (?) may have tricky uid & pwd setup `  
* Default folder: /etc/postgresql
  * postgresql.conf - for network settings  
  * pg_hba.conf - for authentication settings  
  * pg_ident.conf - for identity mapping  
* Default logging folder: /var/log/postgresql  
* Default socket & host: /var/run/postgresql & 5432  
* ` psql -V ` : version -V not -v  
* ` netstat -nlt ` : display listening tcpip connections  
* ` service postgresql < status | start | stop | restart > ` : !
<br><br>

### Admin
#### Before login  
* ` psql -l ` : list databases  
* ` psql -d < database > ` : connect to database  
<br>

#### After login  
* ` \l ` : list databases  
* ` \dn ` : list schemas  
* ` \du ` : list users  
* ` \dv ` : list views  
* ` \conninfo ` : display connection info  
* ` \q ` : quit  
* ` ALTER USER jim WITH PASSWORD 'jimmy'; `  
<br>

#### Views
* Create View from table1
```
CREATE VIEW public."viewTest" AS
 SELECT *
 FROM public.table1;
```
* Drop View
```
DROP VIEW "viewTest";
```
* Scripting
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

### Set up environment to Postgresql with R from Windows
```
# PostgreSQL OR ODBC

# ODBC can (not always) browse the database through the connections window

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


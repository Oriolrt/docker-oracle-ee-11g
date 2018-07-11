# oracle-ee-11g
Oracle Enterprese Edition 11g Release 2 on OracleLinux distriibution 

## Prerequisites:
Download Oracle Enterprise Edition from [Oracle's](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/112010-linx8664soft-100572.html) site:

- linux.x64_11gR2_database_1of2.zip 
- linux.x64_11gR2_database_2of2.zip

## Quick Start

Run with 1521 port opened:
```
docker run -d -p 55121:1521 oriolrt/oracle-ee-11g
```

Run this, if you want the database to be connected remotely:
```
docker run -d -p 55121:1521 -p 55122:22  oriolrt/oracle-xe-11g
```

## How to connect

By default, the password verification is disable(password never expired)
Connect database with following setting:

hostname: localhost  
port: 55121  
sid: ee  

username: system  
password: oracle  
Password for SYS & SYSTEM  

To connect by ssh, the user and pasword are both *oracle*:
```
ssh -p 55121 oracle@localhost
``` 


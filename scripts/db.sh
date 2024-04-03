#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install mysql-server -y
sudo mysql <<BASH_QUERY
CREATE DATABASE northwind;
CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON northwind.* TO 'admin'@'%';
FLUSH PRIVILEGES;
EXIT;
BASH_QUERY

cd ../app
sudo mysql northwind < northwind_sql.sql

# Comment out bind-address in mysql config
sudo sed -i 's/bind-address/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql
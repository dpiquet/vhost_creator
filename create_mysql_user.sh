#!/bin/bash

####################################
#
# Create Mysql User and tables
#
####################################
#
#  Usage: $0 username password
#

__username=$1
__password=$2


# create file to load
__filesql='/tmp/user.sql'

__mysqlPasswd='jjprzdj5'

echo "create user $__username identified by $__password;" > $__filesql
echo "create database $__username;" >> $__filesql
echo "GRANT ALL PRIVILEGES ON $__username.* to $__username;" >> $__filesql

# Load the file in Mysql
mysql -u root -p$__mysqlPasswd < $__filesql


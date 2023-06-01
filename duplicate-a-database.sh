#!/bin/bash
################################
# Set MySQL server credentials #
################################
MYSQL_USER="username"
MYSQL_PASSWORD="password"
MYSQL_HOST="localhost"
MYSQL_PORT="3306"
# ####################
# Set database names #
######################
ORIGINAL_DB="original_database"
NEW_DB="new_database"

# Connect to MySQL server
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT <<EOF
############################################################################


###############################################
# Script to duplicate a database              #
###############################################
# Duplicate database #
######################
CREATE DATABASE $NEW_DB;
USE $NEW_DB;
CREATE TABLESPACE $NEW_DB ADD DATAFILE '$NEW_DB.ibd' ENGINE=InnoDB;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE $NEW_DB.table1 LIKE $ORIGINAL_DB.table1;
INSERT $NEW_DB.table1 SELECT * FROM $ORIGINAL_DB.table1;
CREATE TABLE $NEW_DB.table2 LIKE $ORIGINAL_DB.table2;
INSERT $NEW_DB.table2 SELECT * FROM $ORIGINAL_DB.table2;
SET FOREIGN_KEY_CHECKS=1;

EOF


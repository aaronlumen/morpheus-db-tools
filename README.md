Assuming you have access to the command line of the MorpheusData appliance, you can follow these steps to whitelist IP address 10.10.9.8 to connect to MySQL:

1. SSH into the MorpheusData appliance.
2. Open the MySQL configuration file /etc/mysql/my.cnf in a text editor.
3. Locate the bind-address parameter in the [mysqld] section of the configuration file.
4. Change the value of the bind-address parameter to 0.0.0.0 to allow external connections to the MySQL server.
5. Save and close the configuration file.

6. Restart the MySQL service with the command sudo service mysql restart.
7. Log in to MySQL as the root user with the command mysql -u root -p.
8. Enter the root password when prompted.
9. Run the following SQL command to create a new MySQL user and grant it access from the specified IP address:
#####################################################################
``` CREATE USER 'newuser'@'10.10.9.8' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'10.10.9.8';
FLUSH PRIVILEGES; ```
# Replace newuser and password with the desired username and password for the new MySQL user.
10. Exit the MySQL prompt with the command exit.

# That's it! Now, the IP address 10.10.9.8 should be able to connect to the MySQL server on the MorpheusData appliance using the specified MySQL user credentials.





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
# mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT <<EOF
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
##################################################################################################################################################
# Verify new database was created

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT -e "SHOW DATABASES;"

#############################################################################################################################################################################
# Exit script

exit 0

# This script assumes that the MySQL server is running on the same machine as the script and that you have the necessary permissions to create a new database. 
# You will need to replace the values for MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST, MYSQL_PORT, ORIGINAL_DB, and NEW_DB with your own values.

# The script first connects to the MySQL server using the specified credentials. It then creates a new database with the name NEW_DB, duplicates the tables from the ORIGINAL_DB database into the new database, and sets foreign key checks to 0 to avoid errors during the copying process. After copying the tables, it sets foreign key checks back to 1 and verifies that the new database was created successfully. 
# Finally, the script exits with a status code of 0.




 

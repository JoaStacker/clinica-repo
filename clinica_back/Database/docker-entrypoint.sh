#!/bin/bash
set -x  # Enable debugging

echo "---- STARTING SQL SERVER ----"

# Start the script to create/setup the DB in the background
chmod -R 777 /var/opt/mssql/data
/db-init.sh &

# Start SQL Server 
/opt/mssql/bin/sqlservr

echo "---- db set up finished. ----"

#!/bin/bash
set -x  # Enable debugging

echo "---- STARTING SQL SERVER ----"

# Start the script to create/setup the DB in the background
/db-init.sh &

# Start SQL Server 
/opt/mssql/bin/sqlservr

echo "---- db set up finished. ----"

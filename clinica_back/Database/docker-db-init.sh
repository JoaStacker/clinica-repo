#!/bin/bash
set -e  # Exit on error
set -x  # Enable debugging

# Check if sqlcmd is available
if [ ! -f /opt/mssql-tools18/bin/sqlcmd ]; then
    echo "sqlcmd not found!"
    exit 1
fi

# Initialize the database
sleep 10s

echo "-- INITIALIZING DATABASE --"
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P password@12345# -d master -i clinica-db-init.sql -C &
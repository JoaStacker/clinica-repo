#!/bin/bash
set -e

# Wait for the database to be ready
sleep 30

# Run migrations
dotnet ef database update

# Start the application
exec dotnet Clinica.Api.dll

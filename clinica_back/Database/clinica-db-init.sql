IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'dbclinica')
BEGIN
    CREATE DATABASE dbclinica;
END

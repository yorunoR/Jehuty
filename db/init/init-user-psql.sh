#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER developer WITH PASSWORD 'secret' LOGIN;
    ALTER USER developer CREATEDB CREATEROLE;
EOSQL

psql -v ON_ERROR_STOP=1 --username "developer" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE jehuty_dev;
    CREATE DATABASE jehuty_test;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "jehuty_dev" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS vector;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "jehuty_test" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS vector;
EOSQL

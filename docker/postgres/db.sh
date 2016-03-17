#!/bin/bash

# Wait until PostgreSQL started and listens on port 5432.
while [ -z "`netstat -tln | grep 5432`" ]; do
  echo 'Waiting for PostgreSQL to start ...'
  sleep 1
done
echo 'PostgreSQL started.'

echo "Initializing DB..."

cp $OO_HOME/dist/cms-db-pkg/db/single_db_schemas.sql /var/lib/pgsql/single_db_schemas.sql

cd /var/lib/pgsql
su postgres -c 'psql -f /var/lib/pgsql/single_db_schemas.sql'


cd $OO_HOME/dist/cms-db-pkg/db

export PSQL=psql

# set kloopzcm pass
export PGPASSWORD=kloopzcm

$PSQL -U kloopzcm -h postgres -d kloopzdb -f kloopzcm-schema.sql
RETVAL=$?
[ $RETVAL -ne 0 ] && echo create schema failed && exit 1

# create tables in the schema
$PSQL -U kloopzcm -h postgres -d kloopzdb -f kloopzcm-tables.ddl
RETVAL=$?
[ $RETVAL -ne 0 ] && echo create tables failed && exit 1

# create partition tables in the schema
$PSQL -U kloopzcm -h postgres -d kloopzdb -f kloopzcm-partition.ddl
RETVAL=$?
[ $RETVAL -ne 0 ] && echo create partition tables failed && exit 1

$PSQL -U kloopzcm -h postgres -d kloopzdb -f kloopzcm-postprocess.sql
RETVAL=$?
[ $RETVAL -ne 0 ] && echo post process failed && exit 1

$PSQL -U kloopzcm -h postgres -d kloopzdb -f kloopzcm-functions.sql
RETVAL=$?
[ $RETVAL -ne 0 ] && echo functions failed && exit 1

exit 0

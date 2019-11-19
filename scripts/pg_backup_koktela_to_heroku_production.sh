#!/bin/bash
# This script is intended to be stored in a cron job and e executed at least 2 times per day. 
# The idea is to create a dump of the DataBase in the localhost, which is the most updated and represents information in real time. Then this dumped file is uploaded in AmazonAWS S3 storage but first the last updated version is backuped as .old file.
# Finally the heroku DB is restores from the static URL saved as $HEROKU_PRODUCTION_DB_DUMP

# Is the $HEROKU_PRODUCTION_DB_DUMP defined?
if [ -z "$HEROKU_PRODUCTION_DB_DUMP" ]; then
  echo "HEROKU_PRODUCTION_DB_DUMP is not defined";
  echo "It will be defined as:";
  echo "http://imagineing.s3.amazonaws.com/SOPA-BAR.dump";
  export HEROKU_PRODUCTION_DB_DUMP='http://imagineing.s3.amazonaws.com/SOPA-BAR.dump';
  #exit 1;
fi
# Is the $DATABASE_URL defined?
if [ -z "$DATABASE_URL" ]; then
  echo "DATABASE_URL is not defined";
  echo "It will be defined as:";
  echo "postgresql://imagineing:admin@localhost:5432/SOPA-BAR?ssl=true";
  export DATABASE_URL='postgresql://imagineing:admin@localhost:5432/SOPA-BAR?ssl=true';
  #exit 1;
fi

# Create a Heroku Capture before proceed.
/usr/local/bin/heroku pg:backups:capture DATABASE_URL --app sopa-bar > /tmp/pg_backup_koktela_to_heroku_production_error.log 2>&1;

# Dump the local DB in /tmp/SOPA-BAR.dump
rm -rf /tmp/SOPA-BAR.dump >> /tmp/pg_backup_koktela_to_heroku_production_error.log 2>&1;
pg_dump -Fc --no-acl --no-owner $DATABASE_URL > /tmp/SOPA-BAR.dump 2>> /tmp/pg_backup_koktela_to_heroku_production_error.log;

# Move the last dumped filed to the old in s3 storage
/home/imagineing/.local/bin/aws s3 cp s3://imagineing/SOPA-BAR.dump s3://imagineing/SOPA-BAR.dump.old >> /tmp/pg_backup_koktela_to_heroku_production_error.log 2>&1;
# Upload the new version of SOPA-BAR.dump
/home/imagineing/.local/bin/aws s3 cp /tmp/SOPA-BAR.dump s3://imagineing/SOPA-BAR.dump --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers >> /tmp/pg_backup_koktela_to_heroku_production_error.log 2>&1;

# Restore Heroku Production DB
/usr/local/bin/heroku pg:backups:restore $HEROKU_PRODUCTION_DB_DUMP DATABASE_URL --app sopa-bar --confirm sopa-bar >> /tmp/pg_backup_koktela_to_heroku_production_error.log 2>&1;
exit 0;

# Heroku-Postgres-Import
Useful commands to create backups and replicate from LocalHost Postgresql DB to Heroku DB

## Create BackUp from Local DB
```PGPASSWORD=admin pg_dump -Fc --no-acl --no-owner -h localhost -U myuser SOPA-BAR > SOPA-BAR.dump```

*Optionally*: Create a DATABASE\_URL Variable and use it with pg_dump:
```DATABASE_URL=postgresql://imagineing:admin@localhost:5432/SOPA-BAR?ssl=true```
```pg_dump -Fc --no-acl --no-owner $DATABASE_URL > SOPA-BAR.dump```

## Finally
Add the crontab -e
`0 */4 * * * sh $HOME/local/sopa-bar/scripts/pg_backup_koktela_to_heroku_production.sh && curl -sm 30 k.wdt.io/jchavarria@imagineing.com/koktela-db-restore-to-production?c=0_*/4_*_*_*`

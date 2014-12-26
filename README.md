The cookbook used to setup docker images and containers for [Happiness Service](https://github.com/austenito/happiness_service) and [Happiness](https://github.com/austenito/happiness)

# Backup and restore postgres

## Add this to a cron task
```
sudo docker run --link postgres:db -v <local backup dir>:/backup -e "PGPASSWORD=<password>" austenito/postgres-backup:<tag>
```

## Restore DB

```
sudo docker run -i -t --link postgres:db -v <local backup dir>:/backup austenito/postgres:9.3 /bin/bash
```

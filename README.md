The cookbook used to setup docker images and containers for [Happiness Service](https://github.com/austenito/happiness_service) and [Happiness](https://github.com/austenito/happiness)

# Backup and restore postgres

## Create container used to run the pgdump script

```
sudo docker run --link postgres:db -v <local backup dir>:/backup --name postgres-backup -e "PGPASSWORD=<password>" austenito/postgres-backup:<tag>
```

## Then create a cron task to start the container
```
sudo docker start postgres-backup
```

## Restore DB

```
sudo docker run -i -t --link postgres:db -v <local backup dir>:/backup austenito/postgres:9.3 /bin/bash
```

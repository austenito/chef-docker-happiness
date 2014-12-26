FROM austenito/postgres:9.3

USER root

RUN mkdir /backups

ADD backup.sh /tmp/postgres-backup/backup.sh
RUN chmod +x /tmp/postgres-backup/backup.sh

VOLUMES ['/backups']

CMD /tmp/postgres-backup/backup.sh


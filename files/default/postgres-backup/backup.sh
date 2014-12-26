#!/bin/bash
now=$(date +"%m_%d_%Y")

pg_dumpall -U postgres -h $DB_PORT_5432_TCP_ADDR | gzip > /backup/$now.dump

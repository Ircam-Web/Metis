#!/bin/bash

echo "----------------------------"
echo `date +\%Y\%m\%d-\%H-\%M-\%S`
docker-compose run db /srv/bin/backup_db.sh
cd var
git add .
git commit -a -m "update DB and media"
git pull origin master
git push origin master

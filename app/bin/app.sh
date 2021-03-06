#!/bin/bash

# paths
app='/srv/app'
manage=$app'/manage.py'
wsgi=$app'/wsgi.py'
static='/srv/static/'
media='/srv/media/'
src='/srv/src/'
log='/var/log/uwsgi/app.log'

# uwsgi params
port=8000
processes=8
threads=2
autoreload=3
uid='www-data'
gid='www-data'
# patterns='*.js;*.css;*.jpg;*.jpeg;*.gif;*.png;*.svg;*.ttf;*.eot;*.woff;*.woff2'

# Install a package in development mode
# without rebuidling docker image.
# You need at first checkout your sources in 'lib' folder
# in host project side, then run :
# pip install -e /srv/lib/mypackage...

# Install (staging) libs
# /srv/bin/build/local/setup_lib.sh

# waiting for other services
sh $app/bin/wait.sh

# django setup
#python $manage wait-for-db

# initial setup
if [ ! -f .init ]; then
    bash $app/bin/init.sh
    touch .init
fi

# app start
if [ "$1" = "--runserver" ]; then
    python $manage runserver 0.0.0.0:8000
else
    # static files auto update
    # watchmedo shell-command --patterns="$patterns" --recursive \
    #     --command='python '$manage' collectstatic --noinput' $app &

    python $manage collectstatic --noinput

    uwsgi --socket :$port --wsgi-file $wsgi --chdir $app --master \
    --processes $processes --threads $threads \
    --uid $uid --gid $gid --logto $log --touch-reload $wsgi
fi

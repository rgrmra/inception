#!/bin/ash

exec gunicorn -w 4 -b 0.0.0.0:$STATIC_SITE_PORT app:app 

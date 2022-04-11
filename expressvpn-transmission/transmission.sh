#!/usr/bin/bash

param=" --allowed ${T_ALLOWED}"
param="${param} --foreground"
param="${param} --encryption-preferred"
param="${param} --dht"
param="${param} --config-dir /transmission/config"
param="${param} --download-dir /transmission/complete"
param="${param} --incomplete-dir /transmission/incomplete"
if [ -n "$T_USERNAME" ] && [ -n "$T_PASSWORD" ]
then
    param="${param} --auth"
    param="${param} --username ${T_USERNAME}"
    param="${param} --password ${T_PASSWORD}"
else
    param="${param} --no-auth"
fi
/usr/bin/transmission-daemon ${param}

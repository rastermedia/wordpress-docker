#!/bin/bash
set -e
. /etc/default/apache2
. /etc/apache2/envvars
exec "$@"

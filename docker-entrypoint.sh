#!/bin/bash
set -e
. /etc/default/apache2
exec "$@"

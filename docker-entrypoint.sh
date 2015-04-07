#!/bin/bash

DESC="web server"
NAME=apache2
DAEMON=/usr/sbin/$NAME

SCRIPTNAME="${0##*/}"
SCRIPTNAME="${SCRIPTNAME##[KS][0-9][0-9]}"
if [ -n "$APACHE_CONFDIR" ] ; then
  if [ "${APACHE_CONFDIR##/etc/apache2-}" != "${APACHE_CONFDIR}" ] ; then
          DIR_SUFFIX="${APACHE_CONFDIR##/etc/apache2-}"
  else
          DIR_SUFFIX=
  fi
elif [ "${SCRIPTNAME##apache2-}" != "$SCRIPTNAME" ] ; then
  DIR_SUFFIX="-${SCRIPTNAME##apache2-}"
  APACHE_CONFDIR=/etc/apache2$DIR_SUFFIX
else
  DIR_SUFFIX=
  APACHE_CONFDIR=/etc/apache2
fi
if [ -z "$APACHE_ENVVARS" ] ; then
  APACHE_ENVVARS=$APACHE_CONFDIR/envvars
fi
export APACHE_CONFDIR APACHE_ENVVARS

ENV="env -i LANG=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
if [ "$APACHE_CONFDIR" != /etc/apache2 ] ; then
  ENV="$ENV APACHE_CONFDIR=$APACHE_CONFDIR"
fi
if [ "$APACHE_ENVVARS" != "$APACHE_CONFDIR/envvars" ] ; then
  ENV="$ENV APACHE_ENVVARS=$APACHE_ENVVARS"
fi


#edit /etc/default/apache2 to change this.
HTCACHECLEAN_RUN=auto
HTCACHECLEAN_MODE=daemon
HTCACHECLEAN_SIZE=300M
HTCACHECLEAN_DAEMON_INTERVAL=120
HTCACHECLEAN_PATH=/var/cache/apache2$DIR_SUFFIX/mod_cache_disk
HTCACHECLEAN_OPTIONS=""

# Read configuration variable file if it is present
if [ -f /etc/default/apache2$DIR_SUFFIX ] ; then
  . /etc/default/apache2$DIR_SUFFIX
elif [ -f /etc/default/apache2 ] ; then
  . /etc/default/apache2
fi

PIDFILE=$(. $APACHE_ENVVARS && echo $APACHE_PID_FILE)

VERBOSE=no
if [ -f /etc/default/rcS ]; then
  . /etc/default/rcS
fi
. /lib/lsb/init-functions


# Now, set defaults:
APACHE2CTL="$ENV apache2ctl"
HTCACHECLEAN="$ENV htcacheclean"
PIDFILE=$(. $APACHE_ENVVARS && echo $APACHE_PID_FILE)
APACHE2_INIT_MESSAGE=""

exec "$@"

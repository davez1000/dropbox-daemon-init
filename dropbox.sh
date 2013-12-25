#!/bin/sh

####################################
# Script for running Dropbox daemon.
# Usage:
# /etc/init.d/dropbox start
# /etc/init.d/dropbox stop
#
# etc.
#
# Dropbox dist can be downloaded from the Dropbox site at:
# https://www.dropbox.com/download?plat=lnx.x86 (for 32 bit)
# https://www.dropbox.com/download?plat=lnx.x86_64 (for 64 bit)
####################################

# set up some paths
RUN_AS_USER="dave"
DROPBOX_HOME="/home/$RUN_AS_USER/.dropbox-dist"
CONFIG_HOME="/home/$RUN_AS_USER/.dropbox-config"

start() {
  unset DISPLAY
  echo "Starting dropbox: "
  if [ "x$USER" != "x$RUN_AS_USER" ]; then
    su - $RUN_AS_USER -c "$DROPBOX_HOME/dropboxd & >> $CONFIG_HOME/log.log 2>&1"
  else
    $DROPBOX_HOME/dropboxd & >> $CONFIG_HOME/log.log 2>&1
  fi
  echo "Done."
}

stop() {
  echo "Shutting down dropbox: "
  if [ "x$USER" != "x$RUN_AS_USER" ]; then
    su - $RUN_AS_USER -c "killall -u $RUN_AS_USER dropbox"
  else
    killall -u $RUN_AS_USER dropbox
  fi
  echo "Done."
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
exit 0

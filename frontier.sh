#! /bin/sh
### BEGIN INIT INFO
# Provides:          frontier
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage my cool stuff
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

PID=''

case "$1" in
  start)
    log_begin_msg "Starting Frontier Radio"
    cd /home/pi/frontier-radio
    ./player.sh & export PID=$!
    log_end_msg $?
    exit 0
    ;;
  stop)
    log_begin_msg "Stopping Frontier Radio"
    kill "$PID"
    log_end_msg $?
    exit 0
    ;;
  *)
    echo "Usage: /etc/init.d/frontier.sh {start|stop}"
    exit 1
    ;;
esac
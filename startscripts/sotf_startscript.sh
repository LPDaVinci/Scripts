#!/bin/sh

# Do not change this path
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# The path to the game you want to host. example = /home/newuser/dod
DIR=/var/steamcmd/server/sotf
DAEMON=$DIR/SonsOfTheForestDS.exe

# Change all PARAMS to your needs. xvfb-run is important when using a linux server without desktop env
PARAMS="xvfb-run wine"
CONFDIR='-userdatapath config'
NAME=forest
DESC="forest dedicated Server"

case "$1" in
	start)
		echo "Starting $DESC: $NAME"
		if [ -e $DIR ]; then
			cd $DIR
			screen -d -m -S $NAME $PARAMS $DAEMON $CONFDIR
		else
			echo "No such directory: $DIR!"
		fi
		;;

	stop)
		if screen -ls |grep $NAME; then
			echo -n "Stopping $DESC: $NAME"
			kill `screen -ls |grep $NAME |awk -F . '{print $1}'|awk '{print $1}'`
			echo " ... done."
		else
			echo "Couldn't find a running $DESC"
		fi
		;;

	restart)
		if screen -ls |grep $NAME; then
			echo -n "Stopping $DESC: $NAME"
			kill `screen -ls |grep $NAME |awk -F . '{print $1}'|awk '{print $1}'`
			echo " ... done."
		else
			echo "Couldn't find a running $DESC"
		fi
		echo -n "Starting $DESC: $NAME"
		cd $DIR
		screen -d -m -S $NAME $PARAMS $DAEMON $CONFDIR
		echo " ... done."
		;;

	status)
		# Check whether there's a "wine" process
		ps aux | grep -v grep | grep wine > /dev/null
		CHECK=$?
		[ $CHECK -eq 0 ] && echo "SOTFServer is UP" || echo "SOTFServer is DOWN"
		;;

	*)
		echo "Usage: $0 {start|stop|status|restart}"
		exit 1
		;;
esac

exit 0

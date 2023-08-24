#!/bin/sh

# Do not change this path
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# The path to the game you want to host. example = /home/newuser/dod
DIR=/var/steamcmd/server/gmod
DAEMON=$DIR/srcds_run_x64

# Change all PARAMS to your needs.
PARAMS="-game garrysmod -autoupdate -steam_dir /var/steamcmd/server -steamcmd_script /var/steamcmd/server/gmod/update_gmod.txt -tickrate 66 +gamemode terrortown +ip 89.58.48.163 -port 27015  +maxplayers 20 +map ttt_pelicantown +sv_setsteamaccount XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX +host_workshop_collection 745019846 +exec server.cfg"
NAME=SRCDS01
DESC="Gmod dedicated Server"

case "$1" in
	start)
		echo "Starting $DESC: $NAME"
		if [ -e $DIR ]; then
			cd $DIR
			screen -d -m -S $NAME $DAEMON $PARAMS
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
		screen -d -m -S $NAME $DAEMON $PARAMS
		echo " ... done."
		;;

	status)
		# Check whether there's a "srcds" process
		ps aux | grep -v grep | grep srcds_r > /dev/null
		CHECK=$?
		[ $CHECK -eq 0 ] && echo "SRCDS is UP" || echo "SRCDS is DOWN"
		;;

	*)
		echo "Usage: $0 {start|stop|status|restart}"
		exit 1
		;;
esac

exit 0
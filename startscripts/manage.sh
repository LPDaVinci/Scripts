#!/bin/bash
# @By LPDaVinci

# Colors
    NORMAL="\033[0;39m"
    ROT="\033[1;31m"
    GRUEN="\033[1;32m"
    ORANGE="\033[1;33m"
	
# Custom Messages
    MSG_180="In 3 Minuten wird der Server neugestartet !"
    MSG_60="In 60 Sekunden wird der Neustart ausgelöst !"
    MSG_30="30 Sekunden bis zum Neustart !"
	
# Path
    FIVEM_PATH=/home/fivem/FXServer

# Profilefoldername
	SERVERDATA=server-data
# Screen
    SCREEN="fxserver"

cd $FIVEM_PATH	
running(){
    if ! screen -list | grep -q "$SCREEN"
    then
        return 1
    else
        return 0
    fi
}	

case "$1" in
    # -----------------[ Start ]----------------- #
    start)
	if ( running )
	then
	    echo -e "$ROT Der Server [$SCREEN] ist bereits gestartet !$NORMAL"
	else
        echo -e "$ORANGE Der Server [$SCREEN] wird gestartet.$NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "cd "$FIVEM_PATH"/"$SERVERDATA" && bash "$FIVEM_PATH"/run.sh
		"
		echo -e "$ORANGE Neustart der session.$NORMAL"
		sleep 20
		screen -x $SCREEN -X stuff "neustart des sessionmanager
		"
		echo -e "$GRUEN Session ok ! $NORMAL"
		sleep 5
		echo -e "$GRUEN Server ok ! $NORMAL"
	fi
    ;;
    # -----------------[ Stop ]------------------ #
    stop)
	if ( running )
	then
		echo -e "$GRUEN Der Server wird in 10 Sekunden gestoppt. $NORMAL"
        screen -S $SCREEN -p 0 -X stuff "`printf "say $MSG_30\r"`"; sleep 30
		screen -S $SCREEN -X quit
        echo -e "$ROT Der Server [$SCREEN] wird gestoppt.$NORMAL"
		sleep 5
		echo -e "$GRUEN Der Server [$SCREEN] ist ausgeschaltet. $NORMAL"
		rm -R $FIVEM_PATH/$SERVERDATA/cache/
		echo -e "$GRUEN Der Cache wurde bereinigt. $NORMAL"

	else
	    echo -e "Der Server [$SCREEN] ist nicht gestartet."
	fi
    ;;
    # ----------------[ Restart ]---------------- #
	restart)
	if ( running )
	then
	    echo -e "$ROT Der Server [$SCREEN] ist bereits gestartet ! $NORMAL"
	else
	    echo -e "$GRUEN Der Server [$SCREEN] ist ausgeschaltet. $NORMAL"
	fi
	    echo -e "$ROT Der Server wird neugestartet... $NORMAL"
		screen -S $SCREEN -p 0 -X stuff "`printf "say $MSG_180\r"`"; sleep 180
		screen -S $SCREEN -p 0 -X stuff "`printf "say $MSG_60\r"`"; sleep 60
		screen -S $SCREEN -p 0 -X stuff "`printf "say $MSG_30\r"`"; sleep 30
		screen -S $SCREEN -X quit
		echo -e "$GRUEN Der Server ist ausgeschaltet $NORMAL"
		rm -R $FIVEM_PATH/$SERVERDATA/cache/
		echo -e "$GRUEN Der Cache wurde bereinigt. $NORMAL"
		sleep 2
		echo -e "$ORANGE Neustart wird durchgefuehrt ... $NORMAL"
        echo -e "$ORANGE Der Server [$SCREEN] wird gestartet.$NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "cd "$FIVEM_PATH"/"$SERVERDATA" && bash "$FIVEM_PATH"/run.sh
		"
		echo -e "$ORANGE Restart der Session.$NORMAL"
		sleep 20
		screen -x $SCREEN -X stuff "restart sessionmanager
		"
		echo -e "$GRUEN Server [$SCREEN] gestartet ! $NORMAL"
	;;	
    # -----------------[ Status ]---------------- #
	status)
	if ( running )
	then
	    echo -e "$GRUEN [$SCREEN] gestartet. $NORMAL"
	else
	    echo -e "$ROT [$SCREEN]gestoppt. $NORMAL"
	fi
	;;
    # -----------------[ Screen ]---------------- #
    screen)
        echo -e "$GRUEN Screen des Servers [$SCREEN]. $NORMAL"
        screen -R $SCREEN
    ;;
	*)
    echo -e "$ORANGE Verwendung :$NORMAL ./manage.sh {start|stop|status|screen|restart}"
    exit 1
    ;;
esac

exit 0

#!/bin/sh

##variables
#location of bungeecord and minecraft servers
server=/home/minecraft/mcserver/


##screen
#names
server_paper=server


#RAM
# usage 
# 1 Gigabyte, write: 1G
# 1 Gigabyte in Megabyte, write: 1024M
# 512 Megabyte, write: 512M
# 256 Megabyte, write: 256M
# etc..

ram_server1=4G

#no necessary changes beyond this line

name=`basename "$0"`
case "$1" in
start)
	cd $server && screen -AmdS $server_paper java -Xms$ram_server1 -Xmx$ram_server1 -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -DIReallyKnowWhatIAmDoingISwear -jar paper.jar nogui
	sleep 1
	echo "\033[32mBungeeCord and all Minecraft-Servers were started..\033[0m"
	;;
stop)
	screen -S $server_paper -p 0 -X stuff "stop^M"
	sleep 1
	echo "\033[31mBungeeCord and all Minecraft-Servers were stopped..\033[0m"
	;;
reload)
	screen -S $server_paper -p 0 -X stuff "reload^M"
	sleep 1
	echo "\033[31mBungeeCord and all Minecraft-Servers were reloaded..\033[0m"
	;;
restart)
	$0 stop
	$0 start
	;;
info)
	echo "\033[32m$lobby_screen\033[0m server has \033[32m$ram_server1\033[0m Ram. [\033[32m$lobby\033[0m]"
	;;
*)
	echo "\033[31mUsage: './$name (start|stop|restart|reload|info)'\033[0m"
	;;
esac
exit 0

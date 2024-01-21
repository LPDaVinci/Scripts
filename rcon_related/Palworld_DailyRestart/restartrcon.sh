#!/bin/bash

ServerIP="IP:Port"
AdminPassword="Test"
# Function to send RCON command
send_rcon_command() { ./rcon -a $ServerIP -p $AdminPassword "$1"
}
# Send the first RCON command
send_rcon_command "broadcast Server_Restart_in_10_Minuten"
# Wait for 5 seconds
sleep 600
# Send the next RCON command
send_rcon_command "broadcast Server_Restart_in_5_Minuten"
sleep 300
send_rcon_command "broadcast Reboot"
reboot

#!/bin/bash

# List of server hostnames or IP addresses
servers=("server1","server2", "server3")

# SSH username and password
username="username"
password="password"

# Define the command to run
update_command="sudo apt-get update && sudo apt-get upgrade -y"

# Loop through servers
for server in "${servers[@]}"; do
    echo "Updating $server..."
    
    # Use expect to provide the password for SSH
    expect -c "
        spawn ssh $username@$server \"$update_command\"
        expect {
            \"*assword:\" {
                send \"$password\r\"
                exp_continue
            }
            eof
        }
    "

    # Check the exit status of the SSH command
    if [ $? -eq 0 ]; then
        echo "Update completed successfully on $server."
    else
        echo "Error updating $server. Check logs for details."
    fi
done

#!/bin/bash
# Name: James Goyer, Lucas Valleriani, Amando Rivera
# Course: CI 201 
# Purpose: Create menus for system administrator that allows user to manage disk, files, network, processes running, basic utilities, and user accounts.
main_menu() {
    while true; do
        echo "====== Main Menu ======"
        select option in "Disk Management" "File Management" "Network Management" "Process Management" "User Account Management" "Utilities" "Exit"; do
            case $REPLY in
                1) disk_management; break ;;
                2) file_management; break ;;
                3) network_management; break ;;
                4) process_management; break ;;
                5) user_account_management; break ;;
                6) utilities; break ;;
                7) echo "Exiting program"; exit 0 ;;
                *) echo "Invalid input, try again" ; main_menu ;;
            esac
        done
    done
}

disk_management() {
    while true; do
        echo "====== Disk Management ======"
        select option in "Display device information" "Display disk partition information" "Display block device information" "Display mounted disk information" "Return to Main Menu"; do
            case $REPLY in
                1) lsblk ; disk_management;;
                2) sudo fdisk -l ; disk_management;;
                3) sudo blkid ; disk_management;;
                4) mount | column -t ; disk_management;;
                5) echo "Returning to main menu..." ; main_menu; break ;;
                *) echo "Invalid input, try again" ; disk_management  ;;
            esac
        done
    done
}

file_management() {
    while true; do
        echo "====== File Management ======"
        select option in "Present Working Directory" "List Directory Contents" "Create a File" "Change File Permissions" "Remove a File" "Read a File" "Return to Main Menu"; do
            case $REPLY in
                1) pwd ; file_management  ;;
                2) ls -l -t ; file_management  ;;
                3) read -p "Enter file name to create: " filename; touch "$filename" ; file_management  ;;
                4) read -p "Enter file name to change permssions: " filename; read -p "Enter permissions (###): " perms; chmod "$perms" "$filename" ; file_management  ;;
                5) read -p "Enter file name to remove: " filename; rm -i "$filename" ; file_management  ;;
                6) read -p "Enter file name to read: " filename; cat "$filename" ; file_management  ;;
                7) echo "Returning to main menu..." ; main_menu; break ;;
                *)  echo "Invalid input, try again" ; file_management  ;;
            esac
        done
    done
}

network_management() {
    while true; do 
        echo "====== Network Management ======"
        select option in "ifconfig" "ping" "traceroute" "nslookup" "View network interfaces" "View network routing table" "View Current system users" "View Client machine information" "Return to Main Menu"; do
            case $REPLY in
                1) ifconfig ;;
                2) read -p "Enter host to ping: " host; ping -c 4 "$host" ; network_management  ;;
                3) read -p "Enter host to traceroute: " host; traceroute "$host" ; network_management  ;;
                4) read -p "Enter domain to nslookup: " domain; nslookup "$domain" ; network_management ;;
                5) ip link show ; network_management ;;
                6) netstat -rn ; network_management  ;;
                7) who ; network_management   ;;
                8) hostnamectl ; network_management   ;;
                9) echo "Returning to main menu..." ; main_menu; break ;;
                *) echo "Invalid input, try again" ; network_management   ;;
            esac
        done
    done
}

process_management() {
    while true; do
        echo "====== Process Management ======"
        select option in "Display Processes" "Display Processes by usage" "Terminate a Process" "Display Disk Usage" "Display Free Disk Space" "Display System Uptime" "Return to Main Menu"; do
            case $REPLY in
                1) ps aux ; process_management;;
                2) top -n 2 ; process_management;;
                3) read -p "Enter PID to kill (####): " pid; kill "$pid" ; process_management;;
                4) df -h --total; process_management;;
                5) df -h ; process_management;;
                6) uptime ; process_management;;
                7) echo "Returning to main menu..." ; main_menu; break ;;
                *) echo "Invalid option. Try again." ; process_management;;
            esac
        done
    done
}

user_account_management() {
    while true; do
        echo "====== User Account Management ======"
        select option in "Add user" "Delete user" "Lock user password" "Get information on user" "Add group" "Delete group" "Find user" "Find group" "Return to Main Menu"; do
            case $REPLY in
                1) read -p "Enter username to add: " username; sudo adduser "$username" ; user_account_management;;
                2) read -p "Enter username to delete: " username; sudo deluser "$username" ; user_account_management;;
                3) read -p "Enter username to lock: " username; sudo passwd -l "$username" ; user_account_management;;
                4) read -p "Enter username for info: " username; id "$username" ; user_account_management;;
                5) read -p "Enter group to add: " group; sudo addgroup "$group" ; user_account_management;;
                6) read -p "Enter group to delete: " group; sudo delgroup "$group" ; user_account_management;;
                7) read -p "Enter username to find: " username; id "$username" && echo "User exists." || echo "User does not exist." ; user_account_management;;
                8) read -p "Enter group to find: " group; getent group "$group" && echo "Group exists." || echo "Group does not exist." ; user_account_management;;
                9) echo "Returning to main menu..." ; main_menu; break ;;
                *) echo "Invalid option. Try again." ; user_account_management;;
            esac
        done
    done
}

utilities() {
    while true; do
        echo "====== Utilities ======"
        select option in "Date/Time" "Calendar" "View Manual Pages" "Determine File Type" "Determine Command Type" "Sort File" "Search File" "Return to Main Menu"; do
            case $REPLY in
                1) date ;;
                2) cal ;;
                3) read -p "Enter command to view man page: " cmd; man "$cmd" ; utilities;;
                4) read -p "Enter filename to determine type: " filename; file "$filename" ; utilities;;
                5) read -p "Enter command to determine type: " cmd; type "$cmd" ; utilities;;
                6) read -p "Enter input file to sort: " file_a; read -p "Enter output file: " file_b; sort "$file_a" > "$file_b" ; utilities;;
                7) read -p "Enter file to search: " file; read -p "Enter search term: " term; { [ ! -s "$file" ] && echo "$file is empty"; } || grep "$term" "$file" ; utilities;;
                8) echo "Returning to main menu..." ; main_menu; break ;;
                *) echo "Invalid option. Try again." ; utilities ;;
            esac
        done
    done
}

main_menu

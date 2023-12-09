#!/bin/bash
#
# Author: Gizelle Mhariz Stenson
#

# For Stage 1
# Use this function to print out the help message for -h
# or if the user does not provide a valid argument.
#
function print_usage () {
	# echo "print_usage"
    
	echo "Usage: myuseradd.sh -a <login> <passwd> <shell> -add a user account"
	echo "myuseradd.sh -d <login> - remove a user account"
	echo "myuseradd.sh -h    - display this usage message"
}



# For Stage 2:
# Use this function to delete users as described in the
# assignment instructions.
# 
# Arguments : userToDelete
#
function delete_user () {
	if [ $2 = true ]
    then
        userdel -f -r $1
        echo "$1 is deleted"
    else
        echo "ERROR: $1 does not exist"
    fi

}


# For Stage 3:
# Use this function to add users as described in the
# assignment instructions
#
# Arguments : userToAdd, userPassword, shell
# 
function add_user () {
	if [ $4 = false ]
    then
        useradd -m $1 -s $3
        echo "$2" | passwd --stdin "$1"
        echo "$1 ($2) with $3 is added"
    else
        echo "ERROR: $1 exists"
    fi
}



# For Stage1:
# Use this function to parse the command line arguments
# provided to this script to determine which function
# to call.  Example, if -h is used, print_usage
#
function parse_command_options () {

if [ $(getent passwd $2 | wc -c) -ne 0 ]
then
    loginExists=true
else
    loginExists=false
fi

case $1 in

    -h|-H)
        print_usage
        ;;
    -d|-D)
        delete_user "$2" "$loginExists"
        ;;
    -a|-A)
        add_user "$2" "$3" "$4" "$loginExists"
        ;;

    *)
        echo "ERROR: Invalid option: " $1
        print_usage
        ;;
    esac
	
}


#
# This will run and call the parse_command_options function
# and pass all of the arguments to that function
#
parse_command_options "$@"


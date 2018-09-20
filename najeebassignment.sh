
##########################################################################
#
# This is a UNIX administration script
#
# Its purpose is to help the Admin do basic IT Support Work without
# needing to understand how the Unix Script works
#
##########################################################################

# start by displaying the menu options

echo
echo Welcome to the Unix Help Desk
echo
echo a Check the Calendar
echo b Check the Date
echo c Add a new User
echo d Delete an existing User
echo e Modify a User Account
echo f Change the Password of a User
echo g Give a list of all Users on the System
echo h Check when a particular User last logged in
echo i Confirm the Existence of a User
echo j Show all users that are currently logged in
echo k Ping a Remote Server/Machine
echo l Display information about all network interfaces currently in operation
echo m Add a new IP Address
echo n Delete an old IP address
echo o show the ARP Table
echo p Reboot this machine immediately
echo q Show all Reboot Information for this machine
echo r Launch a Regular System Reboot for the machine
echo s Schedule a time when a System Reboot Occurs
echo t Schedule to Reboot the system when no one is logged in
echo u Generate a Health Report
echo v Report on users who have not logged in for a given amount of time.
echo w Check if a Machine is turned on
echo z Exit the Helpdesk

read helpdesk

case $helpdesk in

#####################################################
# The first option tells the Admin the date command 
#####################################################
a)echo
  cal
  sleep 2
   ;;

########################################
# Option b: This shows the current date
########################################

b) echo 
 date
 sleep 2
 ;;

###################################################
# Option c: enables the Admin to add another User
###################################################

c) echo
 echo Type in a Username you wish to add
	 read newuser

 sleep 2
	 useradd -m $newuser
 sleep 2
  ;;

###############################################
# Option d: Enables the Admin to delete a User
###############################################
d) echo
 echo WARNING! The username you enter  will not be able to be recovered!
 sleep 1
 echo Proceed with Caution!

 echo  Type in the User you wish to delete!
 sleep 2
	 read olduser

 userdel  $olduser
 ;;

########################################
#Option e: Modifying the Account details
########################################

e) echo
 echo Please look at my Assignment Report Submission for my code for this option
;;


##########################################################
# Option f: Enables the Admin to change a User's Password
##########################################################

f) echo
 echo Type the User you want to change password
         read changepass

 sleep 2
         passwd $changepass
 echo
 sleep 2

 ;;

#############################################################
# Option g: Tells the Admin all Users that are on the system
#############################################################

g) echo
 awk -F: '{ print $1 }' /etc/passwd
 sleep 2
;;

######################################################################
# Option h: Lets the Admin know when a chosen user was last logged in
######################################################################

h) echo
 echo type in a username
	 read user

 sleep 2
	 last $user | head -1
 sleep 2
 ;;

##################################################
# Option i: Enables the Admin to check if a user is 
#stored on the system and gives feedback on list of 
#users that are found.
##################################################

i) echo
 echo Enter a Username!
 	read finduser
 
 echo Here are your results of Users found:
 echo
 	id -un $finduser
 sleep 2

  ;;

#######################################################################
#Option j: Lets the Admin know who is currently logged into the system
#######################################################################

j) echo

 echo these people are currently logged in:
 sleep 2
	 who
 sleep 2
 ;;

########################################################
#Option k: this command lets the admin ping any machine!
########################################################

k) echo
 echo Enter the name of the Machine you wish to Ping!
 
 read pingmachine

 echo Here is the results:
 sleep 2
 
	ping -c1  $pingmachine || echo You have entered the wrong details!
 
 echo
 sleep 2
 
 ;;

###############################################################################
#Option l: this enables the Admin to have a look at all the Network Interfaces
################################################################################

l) echo
 ifconfig | more
 sleep 2
 ;;

#######################################################
#Option m: this allows an admin to add a new IP address
#######################################################

m)echo
 echo Here you can  add an IP Address
 echo Please follow the instructions!
 sleep 2
 
 echo Please enter your chosen IP Address:
 	read newIPaddress
 sleep 2

 echo

 echo please type in your chosen ethernet file:
	 read devchoice

 echo
	 ipconfig add $newIPaddress $devchoice
 
 ;;

########################################################
#Option n: this allows an Admin to delete an IP Address
########################################################

n) echo 
 echo This will delete an IP address
 
 Proceed with caution!

 sleep 1

 echo enter the IP address you wish to remove:
	 read delIPaddress

 echo enter the Device directory the IP address is stored in:
	 read $devchoice
 
echo The system will now attempt to remove the IP address!
	 ip adress delete $delIPaddress dev $dechoice
;;

##############################
# Option o: Shows the ARP table
##############################

o)echo
 echo this is the ARP Table Details:
 echo
 arp
 sleep 2 
 ;;

##############################################
# Option p: Reboots the system Immediately!
##############################################

p) echo
 echo  this System will now reboot immediately!
 reboot;;

#######################################################################
# Option q: Lets Admin know of all previous reboots that has occurred
#######################################################################

q) echo
 echo The system was last rebooted at:
	 who -b

 sleep 2
 
 echo

 echo All previous reboots by the system are shown below:
	 last reboot
 
sleep 2
;;

#############################################################################
# Option r: this allows the user to activate the system reboots to
# happen every two weeks and lets the admin know if it is the week to reboot.
#############################################################################

r) #!/bin/bash
 echo 
 echo System will now do regular checks on System Reboots every two weeks!
 echo

 SYSTEMREBOOT=$[ $(date +"%V") % 2 ]

 if [ $SYSTEMREBOOT -eq "0" ];
 then
	 reboot 
 else
	 echo "System will reboot next week!"
 fi

 echo
 sleep 1
;;

######################################################################
# Option s: Allows the Admin to schedule when a reboot should happen.
######################################################################

s) echo
 echo You will now Schedule when a System Reboot happens
 
echo Please enter time in 24 hour format you wish the reboot to occur:
	 read time
 
 echo now please enter the month:
	 read month

 echo now please enter the date:
	 read date

 echo now please enter the year:
	 read $year

 reboot | at $time $month $date $year
 ;;

##################################################################
# Option t: This command will search to see if anyone is logged in,
# if No is found to be logged in, the system will reboot
##################################################################

t)  num_pts=$(who | grep 'pts/' | wc -l)
 num_usr=$(who | awk '{print $1}' | sort -u | wc -l)

 if [ $num_pts -eq 0 ] && [ $num_usr -eq 1 ]; 
 then
	 echo "OK to logout" 
 else
	echo People are still logged in!
fi
;;


##################################################################################
# Option u: This command generates a health report, including Memory Usage,
# and CPU statistics,and Network statistics. It will email the report to the user
# this command is to send the information to the admin but does not work.
# | email -s "Network Statistics Report" nh9amt@bolton.ac.uk
##################################################################################

u) echo
 echo Here is your Health Report
 echo the Information shown here will be emailed to the admin!
 
 sleep 1
	echo 
	echo Here are your Memory Usage Information
	 vmstat
 

 
 sleep 2
	echo 
	echo Here are your Network Statistics: 
	 netstat
;;

######################################################################
#Option v: Allows the admin to find inactive users and the 
#inactive time(in terms of days or month ) since their last login. 
######################################################################

v) USERS=`grep -v NOLOGIN /etc/passwd | cut -d: -f1` 
for i in $USERS 
do 
echo "---------- $USER --------------" 
last -4 $i 
done 
OR 
USERS=`grep -v NOLOGIN /etc/passwd | cut -d: -f1` 
for i in $USERS 
do 
echo "---------- $USER --------------" 
last -n 4 $i 
done
;; 

#############################################
#Option w: check if a Machine is turned on
#############################################

w) echo insert the IP address or the machine
	read testip
	/bin/ping $testip -w 2 > /dev/null

 if [ $? = 0 ];

then
	echo "Machine $testip is on"
else
	echo "Machine $testip is not on"

fi;;


###############################################################################
#Option z: Allows the Admin to exit the System without having to run a command
###############################################################################

z) echo
echo Goodbye!
sleep 1;;

*) echo ERROR -  NOT FOUND! ;;


esac

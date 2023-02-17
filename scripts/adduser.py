# importing linrary
import os
import subprocess
import sys
import getpass

# add user function
def add_user():

	# Ask for the input
	username = input("Enter Username ")

	# Asking for users password
	password = getpass.getpass() 
		
	try:
		# executing useradd command using subprocess module
		subprocess.run(['useradd', '-p', password, username ])	
	except:
		print(f"Failed to add user.")					
		sys.exit(1)

add_user()

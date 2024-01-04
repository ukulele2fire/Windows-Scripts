Author: Nathan Nguyen

## Installation

------Before Running Script-----------

	0. Hopefully you extracted this folder to the Documents folder.
	   Otherwise, move it there
	
	1. Open PowerShell and run the command
	
		Set-ExecutionPolicy RemoteSigned
	
	2. Copy "secpol.cfg" file to the C: Drive
	
	3. Boot up PowerShell ISE and open both "Kami.ps1" and "Function.psm1"
	   (Functions is located in the "Module" folder inside the folder labeled "Function")
	
	4. Edit Kami and Function, save, undo this edit, and then save again
	   (I believe this signs the scripts)

## Instructions 

--------To Run Script----------------

	1. Select the "Kami.ps1" tab inside the ISE and press F5

 ## Features

---------What Script Does------------

	1. Configure the audit policies
	2. Configure the firewall and port rules
	3. Configure the local security policy
	4. Configure services
	5. Remove unwanted features
	6. Disable file sharing
	7. Disable remote access
	8. Configure some user account settings (Default Passwd: Sandwich1!)

Users Folder Backup
Ver 1.2 - 2/23/2022
Sebastian Jones

This program will automate the process of copying the data 
within the Users folder of a source volume to another destination.
Developing this software was necessary due to the inconsistent 
performance of the [redacted] program while transferring OneDrive data.
The Robocopy command has proven to be more reliable. This batch 
file has been created to alleviate confusion regarding CMD
commands (especially the extension Robocopy options)

To use:
- The shortcut will give the actual batch file Administrator privileges, preferably run this
- The shortcut will only work on the network drive. Run the hidden batch file manually (as administrator) if running off-network
- When prompted for volume letters, please only enter the letter without any colon or backslash
- Confirm your volume selections and wait until the Robocopy command begins. You will be notified when it finishes.
- A log file will be provided to verify sizes

Explanation of Robocopy options:

/e 			-	Copies all subdirectories
/b 			- 	Gives Robocopy extra permissions to copy otherwise protected files (CMD instance needs Administrator permissions to work)
/sl			-	Does not allow following symbolic links (prevents infinite recursion)
/MT 			- 	Multithreads transfer allowing 8 simultaneous copy procedures to run at once (optimal)
/r:1 			- 	Will retry files once if unable to copy on first try
/w:1 			- 	Will wait 1 second before retrying copy
/log:[log_location] 	- 	Generates log file to review transfer success and statistics
/tee 			- 	Outputs log data to CMD window during transfer for live viewing
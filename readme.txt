Users Folder Backup
Ver 1.8
Sebastian Jones

This program will automate the process of copying the data 
within the Users folder of a source volume to another destination.
Developing this software was necessary due to the inconsistent 
performance of the [redacted] program for two reasons.
1. Complete breakdown in reliability with the increased prevalence of 
    Intel Optane enabled devices.
2. Inconsistent performance regarding the backup of OneDrive data.

The Robocopy command has proven to be more reliable. This batch 
file has been created to alleviate confusion regarding CMD
commands (especially the extension Robocopy options)

Explanation of Robocopy options:

/e 			-	Copies all subdirectories
/b 			- 	Gives Robocopy extra permissions to copy otherwise protected files (CMD instance needs Administrator permissions to work)
/sl			-	Does not allow following symbolic links (prevents infinite recursion)
/MT 			- 	Multithreads transfer allowing 8 simultaneous copy procedures to run at once (optimal)
/r:1 			- 	Will retry files once if unable to copy on first try
/w:1 			- 	Will wait 1 second before retrying copy
/log:[log_location] 	- 	Generates log file to review transfer success and statistics
/tee 			- 	Outputs log data to CMD window during transfer for live viewing
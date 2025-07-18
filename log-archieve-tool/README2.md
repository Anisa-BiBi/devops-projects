##### https://roadmap.sh/projects/log-archive-tool
##### Requirements
The tool should run from the command line, accept the log directory as an argument, compress the logs, and store them in a new directory. The user should be able to:
Provide the log directory as an argument when running the tool.
»» log-archive <log-directory>
The tool should compress the logs in a tar.gz file and store them in a new directory.
The tool should log the date and time of the archive to a file.
»» logs_archive_20240816_100648.tar.gz
##### Solution
We're building a command-line tool (a script) that:

»» Takes a folder (like /var/log) where system logs are stored.
»» Compresses all the files in that folder into a .tar.gz archive.
»» Saves that archive in a separate folder like /home/ec2-user/archived-logs/.
»» Logs the date and time of the archive to a log file for reference.

Step 1: Launched my Amazon Linux EC2 Instance and accessed via putty

Step 2: Create the Directory Structure
Created a directory for my script and archived logs:
»» mkdir -p ~/log-archiver/archived-logs
»» cd ~/log-archiver

Step 3: Create the Bash Script
Named it log-archive.sh and code is in the file 2.log-archive-tool
»» vim log-archive.sh

Step 4: Make the Script Executable
Assigned permissions
»» chmod +x log-archive.sh

Step 5: Run the Script
./log-archive.sh /var/log    # passed /var/log as an argument
I would see something like:
##### Archive created at /home/ec2-user/log-archiver/archived-logs/logs_archive_20250714_103025.tar.gz
And if you check the log:
##### cat ~/log-archiver/archive-log.txt
output: 20250714_103025: Archived /var/log to /home/ec2-user/log-archiver/archived-logs/logs_archive_20250714_103025.tar.gz

To view the contents of a .tar.gz archive (without extracting it), you can use the tar command with the -tzf options.
»» tar -tzf archived-logs/logs_archive_20250714_060758.tar.gz
##### what’s the point of building this whole log-archive tool?
1. Keeps the System Clean
»» Log directories like /var/log grow continuously.
»» Old logs can clutter disk space and make system slower.
»» Archiving and compressing them clears out space without deleting important info.
Example: Instead of keeping 1000 log files lying around, you keep 1 compressed archive file — neat and tidy.

2. Saves Disk Space with Compression
»» A .tar.gz file reduces size by 60–90% depending on the logs.
»» Helps prevent full-disk issues (which can crash systems).
»» Example: 100MB of logs might become just 10–20MB when archived.

3. Organizes Logs by Time
»» Archives are named like logs_archive_20250714_103025.tar.gz, so you can:
»» Quickly find logs from a specific date/time.
»» Maintain log history in an organized way.

4. Retains Logs for Audit/Compliance
»» In secure environments (banks, healthcare, government), log retention is required.
»» This tool helps retain logs in a clean, secure, tamper-proof format.
»» Example: If someone accesses sensitive files, their activity is logged — and you now have a permanent backup.

5. Automates Routine Log Maintenance
»» When combined with a cron job, it runs daily or weekly.
»» No need for sysadmins to manually clean or move logs.
»» Reduces human error and saves time.

and more...

Project URL
##### https://roadmap.sh/projects/server-stats
Goal of this project is to write a script to analyse server performance stats.

##### Requirements
You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

Total CPU usage
Total memory usage (Free vs Used including percentage)
Total disk usage (Free vs Used including percentage)
Top 5 processes by CPU usage
Top 5 processes by memory usage
Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

##### Solution: 
I have used the AWS Amazon linux server which I have accessed via putty. Then created a serverstat.sh file and saved the code inside via vim editor.
Assigned execute permissions to the file. then executed the file via command:
./serverstat.sh 
the output: 

 Server Performance Stats
======================

>> Total CPU Usage:
Used: 6.2%, Idle: 93.8%

>> Memory Usage:
Total: 949 MB, Used: 121 MB, Free: 612 MB (Used: 12.8%)

>> Disk Usage (root partition):
Total: 8.0G, Used: 1.6G, Available: 6.5G (Used: 20%)

>> Top 5 Processes by CPU Usage:
    PID COMMAND         %CPU
      1 systemd          0.2
   1092 systemd-journal  0.1
      2 kthreadd         0.0
      3 rcu_gp           0.0
      4 rcu_par_gp       0.0

>> Top 5 Processes by Memory Usage:
    PID COMMAND         %MEM
   2138 amazon-ssm-agen  2.0
      1 systemd          1.7
   1760 systemd-resolve  1.5
   1092 systemd-journal  1.5
   2344 systemd          1.3

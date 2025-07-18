##### https://roadmap.sh/projects/nginx-log-analyser

The goal of this project is to help you practice some basic shell scripting skills. You will write a simple tool to analyze logs from the command line.

##### Requirements
Download the sample nginx access log file from here. The log file contains the following fields:
IP address
Date and time
Request method and path
Response status code
Response size
Referrer
User agent
You are required to create a shell script that reads the log file and provides the following information:

Top 5 IP addresses with the most requests
Top 5 most requested paths
Top 5 response status codes
Top 5 user agents

##### Solution:
Download the log file:
Using curl:
curl -o nginx-access.log https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log
OR
Using wget:
wget -O nginx-access.log https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log

Commands: 
🔹 1. awk – Pattern scanning and processing language
    Purpose: Parses and analyzes structured text (line by line), often using whitespace or a custom delimiter.
🔹 2. sort – Sort lines of text files
    Purpose: Arranges lines alphabetically or numerically.
🔹 3. uniq – Report or filter repeated lines
    Purpose: Removes consecutive duplicate lines.
🔹 4. head – Display first lines of a file
    Purpose: Prints the first N lines of a file.
🔹 5. grep – Search for patterns in files
    Purpose: Searches for text using regular expressions.
🔹 6. sed – Stream editor for filtering and transforming text
    Purpose: Performs basic text transformations on an input stream (file or input).

The code for the project is in analyze-nginx1.sh
To run this we have to pass the log file and date as argumrnts:
    $ ./analyze-nginx1.sh nginx-access.log

##### output:
Total Requests: 7605
Unique IPs: 360

Top 5 IP addresses:
   1087 178.128.94.113
   1087 142.93.136.176
   1087 138.68.248.85
   1086 159.89.185.30
    277 86.134.118.70

Top 5 Requested Paths:
   4560 /v1-health
    270 /
    232 /v1-me
    127 /v1-list-workspaces
     75 /v1-list-timezone-teams

Top 5 Status Codes:
   5740 200
    937 404
    621 304
    192 400
     31 "-"

Top 5 User Agents:
   4347 DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com)
    513 Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36
    332 Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36
    294 Custom-AsyncHttpClient
    282 Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36

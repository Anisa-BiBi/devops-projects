##### SSH Remote Server Setup:https://roadmap.sh/projects/ssh-remote-server-setup 
The goal of this project is to learn and practice the basics of Linux. You are required to setup a remote linux server and configure it to allow SSH connections.

##### Requirements
You are required to setup a remote linux server and configure it to allow SSH connections.

Register and setup a remote linux server on any provider e.g. a simple droplet on DigitalOcean which gives you $200 in free credits with the link. Alternatively, use AWS or any other provider.
Create two new SSH key pairs and add them to your server.
You should be able to connect to your server using both SSH keys.
You should be able to use the following command to connect to your server using both SSH keys.

##### ssh -i <path-to-private-key> user@server-ip
Also, look into setting up the configuration in ~/.ssh/config to allow you to connect to your server using the following command.

##### ssh <alias>
The only outcome of this project is that you should be able to SSH into your server using both SSH keys. Future projects will cover other aspects of server setup and configuration.

Stretch goal: install and configure fail2ban to prevent brute force attacks

##### Solution:
✅ Part 1: Set Up Remote Linux Server
🔸 Choose a Cloud Provider
> DigitalOcean – https://www.digitalocean.com (You can get $200 free credits for 60 days.)
> AWS EC2 – Free tier eligible for 12 months.
> Alternatives: Vultr, Linode, Oracle Cloud (always free tier), etc

✅ Part 2: Create and Add Two SSH Key Pairs
🔹 Step 1: Generate SSH Keys (on your local machine)
> ssh-keygen -t rsa -b 4096 -f ~/.ssh/key1
> ssh-keygen -t rsa -b 4096 -f ~/.ssh/key2

You'll now have:
~/.ssh/key1 (private) and ~/.ssh/key1.pub (public)
~/.ssh/key2 (private) and ~/.ssh/key2.pub (public)

🔹 Step 2: Upload Public Keys to Remote Server
Assuming your server is accessible by password or privatekey.pem file:
> ssh -i key.pem ec2-user@<public-ip-address> 
OR
> ssh root@your_server_ip

Once logged in:

> mkdir -p ~/.ssh
> nano ~/.ssh/authorized_keys
Paste the content of both key1.pub and key2.pub into that file (each on a new line). Save and exit.

Then give permissions:

> chmod 600 ~/.ssh/authorized_keys
> chmod 700 ~/.ssh
exit

✅ Part 3: Connect to Server Using Both Keys
Try both connections: 
> ssh -i ~/.ssh/key1 user@your_server_ip
> ssh -i ~/.ssh/key2 user@your_server_ip

✅ Part 4: Configure ~/.ssh/config File for Easy Access/connection
Edit or create the file:
> vim ~/.ssh/config

Add entries like:
/ ** Host server-key1
    HostName your_server_ip
    User your_username
    IdentityFile ~/.ssh/key1

Host server-key2
    HostName your_server_ip
    User your_username
    IdentityFile ~/.ssh/key2 **/

Now you can connect simply using: 
> ssh server-key1
> ssh server-key2

# Static Site Server [🔗](https://roadmap.sh/projects/static-site-server)
Setup a basic linux server and configure it to serve a static site.

The goal of this project is to help you understand the basics of setting up a web server using a basic static site served using Nginx. You will also learn how to use rsync to deploy your changes to the server.

## Requirements
Here are the requirements for this project:  

* Register and setup a remote linux server on any provider e.g. a simple droplet on DigitalOcean which     gives you $200 in free credits with the link. Alternatively, use AWS or any other provider.
* Make sure that you can connect to your server using SSH.
* Install and configure nginx to serve a static site.
* Create a simple webpage with basic HTML, CSS and image files.
* Use "rsync" to update a remote server with a local static site.
* If you have a domain name, point it to your server and serve your static site from there. Alternatively, set up your nginx server to serve the static site from the server’s IP address.

You can write a script deploy.sh which when you run will use rsync to sync your static site to the server.
## Outcome:
Once you have completed the project, you should have a basic understanding of how to setup a web server using a basic static site served using Nginx. You should also have a basic understanding of how to use rsync to deploy your changes to the server.

## Solution:
Launch two instances
1. linux server
2. ubuntu client
   * connect them using ssh
   * ssh -i path.pem ec2-user/ubuntu@pub-ip \
I am using Amazon Linux on AWS as the server and Ubuntu as the client machine (because my local machine don't support rsync) and my static site (weather app) is already in a GitHub repository.

### Step 1: Prepare Ubuntu Client (My Local Machine)
   This machine will:
   1. Clone the GitHub repo (weather app)
   2. Use rsync to deploy files to AWS server

  ```
    git clone https://github.com/Anisa-BiBi/weather-application.git 
    cd wearther-app
   ```

### Step 2: Prepare AWS EC2 Server (Amazon Linux)\
 Assuming you’ve already launched your EC2 instance with Amazon Linux:\
   2.1 Make sure NGINX is installed  
   
      ```
      sudo yum update -y
      sudo amazon-linux-extras enable nginx1
      sudo yum install nginx -y
         ```
      
   2.2 Start and Enable NGINX  
      ```
       sudo systemctl start nginx
       sudo systemctl enable nginx 
            ``` \
   2.3 Test NGINX  
      > Open your browser and go to:  
      >`http://<your-ec2-public-ip>`  
      > You should see the default NGINX welcome page.  

### Step 3: On Server(Amazon Linux) Setup Directory to Serve Your Site    
   3.1 Choose a location (e.g., /var/www/weather) and create directory the will host your site files:   
      ```
       sudo mkdir -p /var/www/weather-app
       sudo chown ec2-user:ec2-user /var/www/weather-app
       ```
   3.2 Configure NGINX to Serve Static Files    
      Edit default NGINX config:   
      ```
        vim /etc/nginx/nginx.conf  
        ```
       Under server { ... }, >> update the location / block:  
       ```
      location / {
         root /var/www/weather-app;
         index index.html;
      } ```  
      
      Then restart NGINX:  
   ```
       systemctl restart nginx
   ```
      ------- OR--------
      
      write your custom config file >>> weather.conf

      vim /etc/nginx/conf.d/weather.conf
```
      server {
    listen 80 default_server;
    server_name static-site-server;

    root /var/www/weather-app;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
      }    ```  
```
* NGINX on Amazon Linux often includes both /etc/nginx/nginx.conf and files in /etc/nginx/conf.d/*.conf.  
* Check if there’s a conflicting default.conf:    
* `ls /etc/nginx/conf.d/`
 
If you see default.conf, it may override your weather.conf    
You can safely remove or rename it:
```
` sudo rm /etc/nginx/conf.d/default.conf `

 Before restarting NGINX, always test the configuration:   
```
sudo nginx -t `
 ```
you should see:  
```
-> nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
-> nginx: configuration file /etc/nginx/nginx.conf test is successful
```
  
#### Summary of NGINX Config Structure
we have a main config file:  
   ```
 /etc/nginx/nginx.conf
```
And a subdirectory for virtual hosts:  
```
   /etc/nginx/conf.d/
   ```
our custom site config weather.conf is correctly placed in conf.d/, which is the right spot.  
To check this, we just need to confirm that nginx.conf includes conf.d/*.conf, so your weather.conf is loaded.  
### Step 1: Check Main Config  
Run this:  
```
    cat /etc/nginx/nginx.conf | grep include
   ```
You should see something like:
```
    include /etc/nginx/conf.d/*.conf;
   ```
If you do see that, your weather.conf is being loaded properly  

### Step 4: Prepare for rsync Deployment  
   4.1 Place .pem File on Ubuntu  
      Yes — your AWS .pem file (private key) should be on the Ubuntu client machine since you’ll be running rsync from Ubuntu to Amazon linux on AWS.  
      Copy your .pem file to Ubuntu (e.g., weather-key.pem)  
      Set correct permissions:  
      ```
       chmod 400 weather-key.pem
      ```
### Step 5: Use rsync to Deploy Static Files
Assuming you’re in your repo directory (weather-app/) on Ubuntu and your Amazon linux EC2 username is ec2-user:
      ```
      rsync -avz -e "ssh -i weather-key.pem" ./ ec2-user@<EC2-PUBLIC-IP>:/var/www/weather-app
         ```
#### Optional: Create deploy.sh Script  
   In your repo, create a file named deploy.sh:  
      ```
      #!/bin/bash
      * rsync -avz -e "ssh -i weather-key.pem" ./ ec2-user@<EC2-PUBLIC-IP>:/var/www/weather
      ```
   Make it executable:  
   ```
       chmod +x deploy.sh
   ```
   Then you can deploy by running:  
      ```
      ./deploy.sh
         ```
### Final Result
   Visit http://<EC2-PUB-IP> in browser
   My weather app should be running


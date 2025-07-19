#!/usr/bin/bash
rsync -avz -e "ssh -i weather-key.pem" ./ ec2-user@<EC2-PUBLIC-IP>:/var/www/weather-app

# being on ubuntu client machine my files would get sync to the Amazon linux server EC2 
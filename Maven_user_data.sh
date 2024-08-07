#!/bin/bash

#Set the variable by using below commands and it will help for whale installing maven.
install_dir="/opt/maven"
VERSION=$(curl -s https://maven.apache.org/download.cgi | grep Downloading|awk '{print $NF}' |awk -F '<' '{print $1}' )
sshd_config="/etc/ssh/sshd_config"

#Update
sudo yum update -y

#Changing hostname
hostnamectl set-hostname Maven-Server

#Create devops user with sudo permissions
sudo useradd devops
sudo echo "devops" | passwd --stdin devops
sudo echo "devops	ALL=(ALL)	NOPASSWD: ALL" | tee -a /etc/sudoers
sudo cp "$ssh_config" "$ssh_config.bak"	#Backup the original SSH configuration file
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' "$sshd_config"		#To replace PasswordAuthenticatio no to yes
sudo systemctl restart sshd		#Restart sshd servicess


#Change the /opt owner and group
sudo  chown -r devops:devops /opt

#Install Java
sudo amazon-linux-extras install java-openjdk11 -y

#Install required packages
sudo yum install -y tree git wget 

#Change Directory
cd /opt

#Download the maven zip file.
curl -s https://archive.apache.org/dist/maven/maven-3/${VERSION}/binaries/apache-maven-${VERSION}-bin.zip -o /tmp/apache-maven-${VERSION}-bin.zip

#Unzip zip file.
sudo unzip /tmp/apache-maven-${VERSION}-bin.zip

#Change the file name to maven. It will help for automation.
sudo mv apache-maven-${VERSION} maven

#Change the maven directory owner and group permissions
sudo chown -R devops:devops ${install_dir}

#Create soft link for mvn binary and then check the java and maven version.
sudo ln -s /opt/maven/bin/mvn /bin/mvn

# Create directory for projects
mkdir /opt/Project

#Install Project from git
cd /opt/Project
git clone https://github.com/MithunTechnologiesDevOps/maven-web-application.git
sudo chown -R devops:devops /opt
cd /opt/projects/maven-web-application
mvn clean package
#!/usr/bin/env bash

add-apt-repository -y ppa:webupd8team/java
add-apt-repository -y ppa:cwchien/gradle
apt-get update

apt-get -y install build-essential
apt-get -y install curl
apt-get -y install ruby1.9.3

# install oracle jdk 8 from ppa
debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
apt-get -y install oracle-java8-installer

# install gradle from ppa
apt-get -y install gradle

# install mysql client and server
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get -y install mysql-server
apt-get -y install mysql-client

echo creating mysql user
mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS sampledb"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO sample@'localhost' IDENTIFIED BY 'sample' WITH GRANT OPTION"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO sample@'%'         IDENTIFIED BY 'sample' WITH GRANT OPTION"

echo configuring mysql networking
sed -i 's/127.0.0.1/192.168.33.50/' /etc/mysql/my.cnf
service mysql restart

# install mongo
echo installing mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-10gen

# install elasticsearch
echo installing elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb
dpkg -i elasticsearch-0.90.5.deb

echo configuring elastic search Xms and Xmx
sed -i 's/ES_MIN_MEM=256m/ES_MIN_MEM=2g/' /usr/share/elasticsearch/bin/elasticsearch.in.sh
sed -i 's/ES_MAX_MEM=1g/ES_MAX_MEM=2g/' /usr/share/elasticsearch/bin/elasticsearch.in.sh
service elasticsearch restart

# install ruby gems
echo installing Ruby gems
gem install bundler
(cd /spring-boot-sample && bundle install)

# create run/test scripts
echo """(cd /spring-boot-sample && gradle clean bootRun)
""" > /home/vagrant/start.sh

echo """(cd /spring-boot-sample && ruby ruby/test/run_all.rb)
""" > /home/vagrant/test.sh

chmod +x /home/vagrant/start.sh
chmod +x /home/vagrant/test.sh

echo All done!

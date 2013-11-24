#!/bin/bash

####################################################
#
#  Create vhosts directory and configuration file
#
####################################################
#
# Usage: $0 vhost_domain user_group
#

__a2ensitebin='a2ensite'
__apacheGroup='www-data'

__domain=$1
__user=$2

# Create vhost directory
mkdir /var/www/$__domain
chown $__user:$__apacheGroup -R /var/www/$__domain
chmod 770 -R /var/www/$__domain

# create vhost configuration file
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$__domain.conf
echo "DocumentRoot /var/www/$__domain" >> /etc/apache2/sites-available/$__domain.conf
echo "ServerName $__domain" >> /etc/apache2/sites-available/$__domain.conf
echo "</VirtualHost>"  >> /etc/apache2/sites-available/$__domain.conf

# Activate configuration and reload apache conf
$__a2ensitebin $__domain.conf
/etc/init.d/apache2 reload


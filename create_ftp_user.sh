#!/bin/bash

##############################################
#
#  Create FTP users
#
##############################################
#
#  Usage: $0 username password home_path
#

__username=$1
__userPassword=$2
__homePath=$3

echo $__userPassword
echo $__homePath

# Use apache uid and gid
__UID=33
__GID=33
__authFile='/etc/proftpd/ftpd.passwd'

ftpasswd --passwd --name=$__username --uid=33 --gid=33 --home=$__homePath --shell=/bin/false --file $__authFile --stdin <<_EOT_
$__userPassword
$__userPassword
_EOT_

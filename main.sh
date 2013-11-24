#!/bin/bash

#######################################################
#
#  Create FTP accounts, Mysql Accounts and tables,
#    Apache directory and vhosts, export list to CSV
#
#######################################################

__CSVFile='/root/users.csv'

echo -n "Nombre de Vhosts a creer ?"
read __vhostNumber

echo -n "Prefixe des utilisateurs ?"
read __userPrefix

# Init CSV file
echo "username,password,home,domain name" > $__CSVFile

# Loop the user creation
for (( a=1; a<=$__vhostNumber; a++))
do

    # forge user infos
    curPwd=`date +%N | md5sum | head -c 8`
    curUsername="$__userPrefix$a"
    curDomainName="$curUsername.rt1projw.iutbeziers.fr"
    curHome="/var/www/$curDomainName"

    # create ftp user
    /root/vhosts_creator/create_ftp_user.sh $curUsername $curPwd $curHome 

    # create Mysql user and table
    /root/vhosts_creator/create_mysql_user.sh $curUsername $curPwd

    # create Vhost
    /root/vhosts_creator/create_vhost.sh $curDomainName $curUserName

    # export to CSV
    echo "$curUsername,$curPwd,$curHome,$curDomainName" >> $__CSVFile
done

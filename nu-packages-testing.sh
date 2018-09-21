#!/bin/sh
# miguel ortiz
# validate packages names from dpkg "Package" and rename them properly and generate a file with package's version.
# later move then into our repo

BASEDIR='/srv/jenkins/available_packages/'
REPODIR='/var/www/html/updatesNotebooks/'

for DEBPACKAGE in $BASEDIR* ; do

	if [ -z "$(ls -A $BASEDIR/* |grep .deb)" ]; then
		echo "No .deb packages available in $BASEDIR"
		exit
	fi

 	PACKVERS=`dpkg -I $DEBPACKAGE |grep Version | awk '{print $2}'`
	PACKNAME=`dpkg -I $DEBPACKAGE |grep Package | awk '{print $2}'`
	PACKNAME=`echo $PACKNAME`
	PACKVERS=`echo $PACKVERS`
	DEBPACKAGE=`echo ${DEBPACKAGE##*/}`

	if [ "$DEBPACKAGE" = "$PACKNAME.deb" ]; then
                echo $PACKVERS > "$BASEDIR$PACKNAME.ver"
        else
		mv $DEBPACKAGE $BASEDIR"$PACKNAME.deb"	 
                echo $PACKVERS > "$BASEDIR$PACKNAME.ver"
        fi

	mv "$BASEDIR$PACKNAME.deb" $REPODIR
	cd $REPODIR
  	md5sum *.deb > $REPODIR/availables		
done

#!/bin/sh
# miguel ortiz
# genera los archivos y modificaciones necesarias para que los paquetes .deb en Debian
# sean tomados por actualizador-personalizado en servidor SuSe

BASEDIR='/srv/jenkins/available_packages/'

for DEBPACKAGE in $BASEDIR* ; do
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
done

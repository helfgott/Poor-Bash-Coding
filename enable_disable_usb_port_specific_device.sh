#!/bin/bash
# miguel.ortiz
# enable-disable specific usb port for first device in "devices.list"
# read: http://migueleonardortiz.com.ar/linux/learning-how-to-disable-specific-usb-devices-by-their-ports-in-linux/1645
# to know how to setup "devices.list"
# ---------------------------------------enable this commented lines for logging (and at the end of the script)
#touch cheap_pinpad.log
#exec 1> >(tee -a cheap_pinpad.log) 2>&1

LOCK='/tmp/pinpad.lock'
BINDS='/sys/bus/usb/drivers/usb'
BINDF="$BINDS/bind"
UNBINDF="$BINDS/unbind"
STATUS=$1
# ----VERIFY PARAMETERS ----


if [ "$STATUS" == 'ON' ]
then 
	:	
elif [ "$STATUS" == 'OFF' ]
then
	:
else
	exit 3 # Invalid parameter for this script
fi

# -----DEFINE PORT ------
readarray DEVICES < /usr/local/bin/devices.list

if [ ! -f $LOCK ]
then
        for device in "${DEVICES[@]}" ; do
                DEVPORT=`lsusb | grep $device |awk '{print $2"/"$4}' |tr -d ':'`
		PORTIDX=$(grep -l $DEVPORT /sys/bus/usb/devices/*/uevent | tail -1)
                if [ "$PORTIDX" == '' ]
		then
			exit 4 # no encuentro el dispositivo
                        :
                else
			PORTID=$(echo $PORTIDX | tr "/" " "|awk '{print $5}')
			`echo $PORTID > $LOCK`
                fi
        done
fi

# ------ DEVICE EXISTENCE -------

function verify_device() {
	DEVEXISTS=$(grep -l ".*" /sys/bus/usb/devices/*/uevent | grep $1)
	if [ "$DEVEXISTS" == '' ]
	then
		exit 5 # no encuentro el dispositivo, al parecer fue desconectado 
	else 
		:	
	fi
}


# ----- INTERACT -------
   
if [ -s "$LOCK" ]
then
	DEVPORT=$(cat pinpad.lock)     
	verify_device $DEVPORT
else 
        exit 6 # se registro mal el dispositivo en pinpad.lock
fi 

# ---- Encendido
if [ "$STATUS" == "ON" ] && [ ! -e "$BINDS/$DEVPORT" ]
then
	$(echo -n $DEVPORT > $BINDF) 

elif [ "$STATUS" == "ON" ] && [ -e "$BINDS/$DEVPORT" ]
then
	exit 7 # El dispositivo ya ha sido habilitado
fi

# ---- Apagado
if [ "$STATUS" == 'OFF' ] && [ -e "$BINDS/$DEVPORT" ]
then
	$(echo -n $DEVPORT > $UNBINDF )

elif [ "$STATUS" == 'OFF' ] && [ ! -e "$BINDS/$DEVPORT" ]
then
	exit 8 # Ya esta deshabilitado el puerto USB
fi

# ---------------------------------------enable this commented lines for logging
#echo $ERROR >> cheap_pinpad.log
#echo $OK >> cheap_pinpad.log


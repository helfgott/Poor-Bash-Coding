
#!/bin/bash
# miguel.ortiz
# enable-disable specific port if a device from devices.list were connected 

# Usage: 
# ./enable_disable_usb_port_specific_device.sh ON 	# Enables the device
# ./enable_disable_usb_port_specific_device.sh OFF 	# Disable the device
# devices.list # Must contain the ID from lsusb of the device we want to manage
# for several devices consider adding a new variable!



# ---------------------------------------enable this commented lines for logging (and at the end of the script)
#touch cheap_pinpad.log
#exec 1> >(tee -a cheap_pinpad.log) 2>&1

readarray DEVICES < devices.list
LOCK=pinpad.lock
BINDS='/sys/bus/usb/drivers/usb'
BINDF="$BINDS/bind"
UNBINDF="$BINDS/unbind"
# -----DEFINE PORT ------
if [ ! -f $LOCK ]; then
        for device in "${DEVICES[@]}" ; do
                PORTID=$(grep -l $device /sys/bus/usb/devices/*/uevent | tail -1)
                if [ "$PORTID" == '' ]; then
                        :
                else
                        PORTID=$(echo $PORTID | tr "/" " "|awk '{print $5}')
                fi
        done
fi

# ----- INTERACT -------
    
if [ -s "$LOCK" ]; then
        DEVPORT=$(cat pinpad.lock)        
else
        echo 'ERROR: Device not registered correctly'
        exit 1
fi  

if [ "$1" == 'ON' ] && [ ! -e "$BINDS/$DEVPORT"  ] ; then 
        $(echo -n $DEVPORT > $BINDF)
        OK='PORT Enabled'
else :
        ERROR='ERROR, port already enabled'
fi


if [ "$1" == 'OFF' ] && [ -e "$BINDS/$DEVPORT" ]; then
        $(echo -n $DEVPORT > $UNBINDF)
        OK='PORT Disabled'
else :
        ERROR='ERROR, port already disabled'
fi

# ---------------------------------------enable this commented lines for logging 
#echo $ERROR >> cheap_pinpad.log
#echo $OK >> cheap_pinpad.log
                                                                                                                                    29,1        Final

#!/bin/sh

echo "*********************************"
echo "Started"
echo "*********************************"

echo "*********************************"
echo "Started deleting DerivedData"
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "DerivedData Has Been Deleted"
echo "*********************************"

echo "*********************************"
echo "Started deleting reloading usb deamon"
sudo pkill usbmuxd
echo "usb deamon Has Been reloaded"
echo "*********************************"

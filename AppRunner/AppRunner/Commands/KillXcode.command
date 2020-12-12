#!/bin/sh

echo "*********************************"
echo "Started Killing All Instances Of Xcode"
ps aux | grep -v grep |grep Xcode | awk '{print $2}' | xargs kill
killall Xcode
echo "Xcode Has Been Killed"
echo "*********************************"

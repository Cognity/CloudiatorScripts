#! /bin/bash

REGISTRY=$1
USERNAME=$2
PASSWORD=$3



sudo docker login $REGISTRY -p $USERNAME -u $PASSWORD
sudo docker pull $REGISTRY/dp-es




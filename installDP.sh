#! /bin/bash
REGISTRY=$1
USERNAME=$2
PASSWORD=$3
SERVICE=$4
PULL="Pulling image -->"
DEPLOY="Deploying -->"
sudo docker login $REGISTRY -p $USERNAME -u $PASSWORD

echo "$PULL $SERVICE"
sudo docker pull $REGISTRY/$SERVICE-microservice-public:latest


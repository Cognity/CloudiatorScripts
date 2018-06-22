#! /bin/bash
PULL="Pulling image -->"
DEPLOY="Deploying -->"

# First Argument is the name of the service
service=$1
# Second argument is the exposed port of the container
port=$2
networkMode=$3
REGISTRY=$4
if [ "$networkMode" == "host" ]; then
    echo "$DEPLOY users with host's IP"
    sudo docker run -d -e SPRING_PROFILES_ACTIVE=dev --net=host -p $port:$port -p $(($port+1)):$(($port+1)) --memory=896m --name users -t $REGISTRY/dp/"${service}"-microservice-public:latest
else
    echo "$DEPLOY users with dockers's IP"
    sudo docker run -d -e SPRING_PROFILES_ACTIVE=dev -p $port:$port -p $(($port+1)):$(($port+1)) --memory=896m --name users -t $REGISTRY/dp/"${service}"-microservice-public:latest
fi
# echo "$DEPLOY products"
# sudo docker run -d -e SPRING_PROFILES_ACTIVE=dev --net=host -p 9700:9700 -p 9701:9701 --memory=896m --name products -t $REGISTRY/dp/products-microservice-public:latest
# echo "$DEPLOY customers"
# sudo docker run -d -e SPRING_PROFILES_ACTIVE=dev --net=host -p 9600:9600 -p 9601:9601 --memory=896m --name customers -t $REGISTRY/dp/customers-microservice-public:latest
# echo "$DEPLOY orders"
# sudo docker run -d -e SPRING_PROFILES_ACTIVE=dev --net=host -p 9500:9500 -p 9501:9501 --memory=896m --name orders -t $REGISTRY/dp/orders-microservice-public:latest

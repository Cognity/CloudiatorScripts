#fml
ENV_IP=$2
IS_MASTER=$3

SLAVE_NAME=$4
VOLUME_NAME=$5
NODE_NAME=$6

install() {
sudo -E add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo -E apt-get -y update
sudo -E apt-get -y --allow-unauthenticated install docker-ce

sudo ./installES.sh
}

start() {
    sudo ./runES.sh $ENV_IP $IS_MASTER $SLAVE_NAME $VOLUME_NAME $NODE_NAME 
}

startBlocking() {
      # start haproxy and sleep for infinity
      echo "ECHOING PORTS:"
      echo $CONTAINER_IP
      echo $PUBLIC_IP
      echo $CONTAINER_APACHEPROV
      echo $PUBLIC_APACHEPROV
      echo $CLOUD_APACHEPROV
      sudo ./run.sh 
}

stop() {
    # stop haproxy
sudo docker container stop $(sudo docker ps -q) && sudo docker container rm -f $(sudo docker ps -q)touch Dockerfile
}

### main logic ###
case "$1" in
  install)
        install
        ;;
  start)
        start
        ;;
  startBlocking)
        startBlocking
        ;;
  configure)
        configure
        ;;
  stop)
        stop
        ;;
  *)
        echo $"Usage: $0 {install|start|startBlocking|configure|stop}"
        exit 1
esac

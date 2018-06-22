#! /bin/bash
# $1 = master's node IP address
ENV_IP=$1
IS_MASTER=$2

SLAVE_NAME=$3
VOLUME_NAME=$4
NODE_NAME=$5


echo "$SLAVE_NAME $PUBLIC_PORT $CLUSTER_PORT $VOLUME_NAME $NODE_NAME $MASTER_IP"
#increase vm thing limit; kek
sudo sysctl -w vm.max_map_count=262144
if [ $IS_MASTER == "0" ] 
then
    echo "Deploying master"
    sudo docker run -d --net="host" --memory="2g" --name="es_1" -p 9200:9200 -p 9300:9300 --ulimit nofile=65536:65536 --ulimit memlock=-1:-1 -v esdata1:/usr/share/elasticsearch/data -e cluster.name="cp-es-cluster" -e node.name="cloud1" -e node.master="true" -e http.cors.enabled="true" -e http.cors.allow-origin="*" -e bootstrap.memory_lock="true" -e discovery.zen.minimum_master_nodes="1" -e xpack.security.enabled="false" -e xpack.monitoring.enabled="false" -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -e network.publish_host="${ENV_IP}" cloudperfect.cognity.gr/dp-es
else
    echo "Deploying slave"
    docker run -d --net="host" --memory="2g" --name="$SLAVE_NAME" -p 9200:9200 -p 9300:9300  --ulimit nofile=65536:65536 --ulimit memlock=-1:-1 -v $VOLUME_NAME:/usr/share/elasticsearch/data -e cluster.name="cp-es-cluster" -e node.name="$NODE_NAME" -e node.master="false" -e http.cors.enabled="true" -e http.cors.allow-origin="*" -e bootstrap.memory_lock="true" -e discovery.zen.minimum_master_nodes="1" -e xpack.security.enabled="false" -e xpack.monitoring.enabled="false" -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -e "discovery.zen.ping.unicast.hosts=172.16.12.17" cloudperfect.cognity.gr/dp-es
fi

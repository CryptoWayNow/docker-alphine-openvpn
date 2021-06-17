#!/bin/bash


# Process parameters
PORT=443
PROTOCOL='tcp'
CONFIG_PATH="/home/ovpn"

if [[ "$1" ]]; then
    PORT=$1
fi

if [[ "$2" ]]; then
    PROTOCOL=$2
fi

if [[ "$3" ]]; then
    CONFIG_PATH=$3
fi


echo "recreate config path"
rm -rf $CONFIG_PATH/$PROTOCOL
mkdir -p $CONFIG_PATH/$PROTOCOL

# Remove old image

IMAGE_NAME="ovpn-$PROTOCOL"

echo "Remove Container and IMAGES if exist"
docker images -a | grep "$IMAGE_NAME" | awk '{print $3}' | xargs docker rmi -f
docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}' | xargs docker rm -f



docker build \
  --no-cache \
  -t $IMAGE_NAME .


docker create \
  --cap-add=NET_ADMIN \
  --name=ovpn-$PROTOCOL \
  --network=host \
  --privileged \
  -e PROTO=tcp \
  -e PORT=1194 \
  -e INTERFACE='eth0' \
  -p $PORT:443/$PROTOCOL \
  -v $CONFIG_PATH:/config \
  --restart always \
  $IMAGE_NAME
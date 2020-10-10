#!/bin/bash

# Ensure container is stopped and deleted before updating.
docker container stop bastion
docker container rm bastion

while IFS='=' read -r name value
do
  export $name=${value//\'/}
done < ../etc/bastion.config

docker build \
  --no-cache -t bastion .

# TODO: HACKTAG: There's some sort of race condition that causes this to fail if it executes too
# soon.  It would be better to watch output from `docker image ls` or something.
sleep 5

# Start Bastion server.
docker run \
  -d \
  --name bastion \
  -h bastion \
  -p "${bastion_ip}":"${bastion_port}":"${bastion_port}" \
  bastion

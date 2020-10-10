#!/bin/bash

while IFS='=' read -r name value
do
  export $name=${value//\'/}
done < bastion.config

docker build \
  --build-arg local_user="${local_user}" \
  --build-arg local_user_password="${local_user_password}" \
  --build-arg root_password="${root_password}" \
  --no-cache \
  -t bastion .

docker run \
  -d \
  --name bastion \
  -h bastion \
  -p "${bastion_ip}":"${bastion_port}":"${bastion_port}" \
  bastion

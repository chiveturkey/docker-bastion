# docker-bastion

A simple bastion in a docker container.

## Prerequisites

* Create `bastion.config` file with `local_user`, `local_user_password`, `root_password`, and `bastion_ip`.  See `bastion.config.EXAMPLE` for details.
* Functional Docker environment.

## Setup Secondary IP on Docker Server

Assign a secondary IP on the Docker server for use by the bastion container.  This IP should match `bastion_ip` in the `bastion.config`.  The method for setting up a secondary IP depends on your distribution.

* Example.  On CentOS 7, add a secondary IP.  Here we assume that our network interface card is called `enp1s0`, and the secondary IP we want to add is `192.168.100.1`.

```
nmcli connection modify enp1s0 +ipv4.addresses "192.168.100.1/24"
```

## Build and Run Bastion

The `build.sh` script will build the bastion container image and will then run it.

* Build bastion image.

```
./build.sh
```

## Security

Ideally, this environment is behind an edge firewall of some sort.  For additional security, configure iptables on the Docker server to only allow certain source IP ranges.  The DOCKER-USER chain can be used for this purpose.  See iptables.EXAMPLE for details.  The iptables.EXAMPLE file allows several source IP ranges to connect to port 22 and then rejects all others.

## Reference

* https://docs.docker.com/network/iptables/

## Update Bastion

The `update.sh` script will rebuild the bastion container image and will then run it.

```
./update.sh
```

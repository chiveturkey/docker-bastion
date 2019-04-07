# docker-bastion

A simple bastion in a docker container.

## Prereq

* Create bastion.config file with local_user, local_user_password, and root_password.  See bastion.config.EXAMPLE for
details.
* Functional Docker environment

## Setup

* Build bastion image.

```
./build.sh
```

* Assign secondary IP on Docker server.  We will refer to it as [Secondary Docker IP].

## Run

* Run bastion container.  Use the [Secondary Docker IP] from above.

```
docker run -d --name bastion -h bastion -p [Secondary Docker IP]:[External Port]:22 bastion
```

* Example.  This will forward incoming traffic on 192.168.100.10:22 to the bastion container on port 22.

```
docker run -d --name bastion -h bastion -p 192.168.100.10:22:22 bastion
```

## Security

Ideally, this environment is behind an edge firewall of some sort.  For additional security, configure iptables on
the Docker server to only allow certain source IP ranges.  The DOCKER-USER chain can be used for this purpose.  See
iptables.EXAMPLE for details.  The iptables.EXAMPLE file allows several source IP ranges to connect to port 22 and then
rejects all others.

## Reference

* https://docs.docker.com/network/iptables/

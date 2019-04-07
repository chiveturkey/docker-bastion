FROM centos:7

ARG local_user
ARG local_user_password
ARG root_password

# Update and install some useful packages.
RUN yum update -y && \
  yum install traceroute bind-utils mailx nmap-ncat vim-enhanced bash-completion openssh-server openssh-clients -y

# Add local user, and set passwords.
RUN adduser $local_user && \
  echo $local_user_password | passwd --stdin $local_user && \
  echo $root_password | passwd --stdin root

# Configure SSH.
# NOTE: We may end up needing to create SSH host keys locally, depending on how often the bastion
# is rebuilt.  Otherwise, clients would be getting host key mismatch errors all of the time.
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
  echo "AllowUsers $local_user" >> /etc/ssh/sshd_config && \
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa -b 4096 -N '' && \
  ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -t ecdsa -b 521 -N '' && \
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -t ed25519 -N ''

CMD /usr/sbin/sshd -D

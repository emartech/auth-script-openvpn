FROM centos:7

RUN yum -y install epel-release && \
  yum -y update && \
  yum -y groupinstall "Development Tools" && \
  yum -y install openvpn-devel


WORKDIR /usr/local/auth-script-openvpn

COPY . /

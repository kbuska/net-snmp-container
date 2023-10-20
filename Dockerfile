FROM ubuntu:22.04

LABEL maintainer="Ken Buska NET-SNMP <kbuska@noanet.net>"

RUN set -x apt-update && \
    apt install snmpd -y && \
    apt install libltdl-dev -y && \
    apt install libperl-dev -y && \
    apt install wget -y && \
    apt install build-essentials -y
 
RUN set -x \
wget https://gigenet.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.tar.gz && \
tar -xf net-snmp-5.9.4.tar.gz && \
cd net-snmp-5.9.4 && \
./configure --with-defaults --with-default-snmp-version="2" && \
make && \
# make install
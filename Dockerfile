FROM ubuntu:22.04

LABEL maintainer="Ken Buska NET-SNMP <kbuska@noanet.net>"

RUN apt update && \
apt install snmpd -y && \
apt install libltdl-dev -y && \
apt install libperl-dev -y && \
apt install wget -y && \
apt install build-essential -y && \
wget https://gigenet.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.tar.gz && \
tar -xf net-snmp-5.9.4.tar.gz && \
rm net-snmp-5.9.4.tar.gz && \
cd net-snmp-5.9.4 && \
sh ./configure --with-defaults --with-default-snmp-version="2"

WORKDIR /net-snmp-5.9.4
RUN make && make install && make clean

ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV MIBS ALL
ENV MIBDIRS /net-snmp-5.9.4/mibs:/mibs:/root/.snmp/mibs:/usr/local/share/snmp/mibs

WORKDIR /net-snmp-5.9.4/mibs

VOLUME [/mibs]

WORKDIR /

COPY setup_mibdirs.sh /setup_mibdirs.sh

ENTRYPOINT ["/setup_mibdirs.sh"]
CMD ["your-default-command"]

HEALTHCHECK --interval=30s --timeout=3s \
  CMD snmptranslate 1.3.6.1.4.1.2544.1.12.8.1.21.1 || exit 1
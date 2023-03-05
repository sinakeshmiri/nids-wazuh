#! /bin/bash

#setup interface 
printf "
auto %s
iface %s inet manual
  up ifconfig \$IFACE -arp up
  up ip link set \$IFACE promisc on
  down ip link set \$IFACE promisc off
  down ifconfig \$IFACE down
  post-up for i in rx tx sg tso ufo gso gro lro; do ethtool -K \$IFACE \$i off; done
  post-up echo 1 > /proc/sys/net/ipv6/conf/\$IFACE/disable_ipv6
" $1 > /etc/network/interfaces

#setup docker env file
printf "IF=%s" $1 > .env

#downloading suricata rules and config
mkdir files
cd files
wget https://rules.emergingthreats.net/open/suricata-6.0.3/emerging.rules.tar.gz
tar zxvf emerging.rules.tar.gz
wget -O suricata.yaml https://packages.wazuh.com/4.3/suricata.yml
cd ..
docker-compose up -d

cat agent.conf >> /var/ossec/etc/shared/Suricata/agent.conf

systemctl restart wazuh-agent

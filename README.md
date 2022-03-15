# zeekwazuh
zeek wazuh  
donwload docker image  
```
docker pull ghaem51/zeekwazuh:1.0.0
```
after that clone repo and run
```
docker-compose up
```
default log path /var/log/zeek  
default interface eno1  
edit docker-compose for update log path and interface  
example log output:  
conn.log
```
{
  "ts": "2022-03-15T12:57:59.305343Z",
  "uid": "CqWXmb3AnR6tEhsUZk",
  "identifier.orig_h": "172.30.200.186",
  "identifier.orig_p": 38882,
  "identifier.resp_h": "142.250.179.163",
  "identifier.resp_p": 443,
  "proto": "udp",
  "duration": 0.2741379737854004,
  "orig_bytes": 0,
  "resp_bytes": 5630,
  "conn_state": "SHR",
  "missed_bytes": 0,
  "history": "Cd",
  "orig_pkts": 0,
  "orig_ip_bytes": 0,
  "resp_pkts": 7,
  "resp_ip_bytes": 5826,
  "bro_engine": "CONN"
}
```
I change id field with identifier and add bro_engine to simple rule decode for wazuh  
wazuh agent group config:
```
<agent_config>
	<localfile>
		<log_format>syslog</log_format>
		<location>/var/log/zeek/conn.log</location>
	</localfile>
	<localfile>
		<log_format>syslog</log_format>
		<location>/var/log/zeek/dns.log</location>
	</localfile>
	<localfile>
		<log_format>syslog</log_format>
		<location>/var/log/zeek/ssl.log</location>
	</localfile>
	<localfile>
		<log_format>syslog</log_format>
		<location>/var/log/zeek/weird.log</location>
	</localfile>
</agent_config>
```
wazuh log report:
![image](https://user-images.githubusercontent.com/17712146/158383141-81125a6c-255f-4e3a-916f-ecfc00f47893.png)


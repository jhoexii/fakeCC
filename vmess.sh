#!/bin/bash
wget -O install.sh 165.22.97.197/dolor/v2ray.sh; chmod +x install.sh; ./install.sh
sleep 3
cat << \websock > /etc/v2ray/config.json
{
  "log": {
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log",
        "loglevel": "warning"
    },
  "inbounds": [
    {
    "port":24344,
      "listen": "127.0.0.1", 
      "tag": "vmess-in", 
      "protocol": "vmess", 
      "settings": {
        "clients": [
          {
	  "id":"00a4c4e7-942d-4d65-b252-05b57fdebc19",
	  "alterId":0
          }
        ]
      }, 
      "streamSettings": {
        "network": "ws", 
        "wsSettings": {
	  "path":"/jhoelsoft/"
        }
      }
    }
  ], 
  "outbounds": [
    {
      "protocol": "freedom", 
      "settings": { }, 
      "tag": "direct"
    }, 
    {
      "protocol": "blackhole", 
      "settings": { }, 
      "tag": "blocked"
    }
  ], 
  "dns": {
    "servers": [
      "https+local://1.1.1.1/dns-query",
	  "1.1.1.1",
	  "1.0.0.1",
	  "8.8.8.8",
	  "8.8.4.4",
	  "localhost"
    ]
  },
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "vmess-in"
        ],
        "outboundTag": "direct"
      }
    ]
  }
}
websock
service v2ray restart

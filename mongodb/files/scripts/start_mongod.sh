#!/bin/bash

# Set the hostname in /etc/hosts
HOST_IP=$(/sbin/ip route|awk '/link/ { print $9 }')
echo "Host IP is: $HOST_IP"
echo "$HOST_IP mongod" >> /etc/hosts

# Start mongod (defaults to listening on port 27018)
mongod --shardsvr --replSet storjsdk --sslPEMKeyFile /etc/mongodb.pem --sslMode requireSSL --sslAllowInvalidCertificates --sslAllowInvalidHostnames --sslAllowConnectionsWithoutCertificates &

sleep 10

# Initiate the replicaset
mongo --port 27018 --ssl --sslAllowInvalidHostnames --sslAllowInvalidCertificates --eval '
rs.initiate(
   {
      _id: "storjsdk",
      members: [
         { _id: 0, host : "mongod:27018" }
      ]
   }
)
'

sleep infinity

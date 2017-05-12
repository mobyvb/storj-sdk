#!/bin/bash

# Start mongos
mongos --configdb storjsdkcfg/mongoc:27019 --sslPEMKeyFile /etc/mongodb.pem --sslMode requireSSL --sslAllowInvalidCertificates --sslAllowInvalidHostnames --sslAllowConnectionsWithoutCertificates &

sleep 10

mongo --ssl --sslAllowInvalidCertificates --sslAllowInvalidHostnames --eval "sh.addShard('storjsdk/mongod:27018')" &

sleep infinity

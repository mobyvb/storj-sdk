#!bin/bash
auth_file_name=$(echo $STORJ_BRIDGE | cut -d'/' -f 3 | cut -d':' -f 1)
cp ~/.storj/localbridge.json ~/.storj/$auth_file_name.json
echo "Auth file copied to ~/.storj/$auth_file_name.json"

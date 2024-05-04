#!/bin/bash

# [ generating ssl certificates ]
echo "[ nginx ] generating ssl certificate..."
mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ouhassna.key \
    -out /etc/nginx/ssl/ouhassna.crt  \
    -subj "/C=MA/L=Martil/O=42/OU=1337 MED/CN=ouhassna.42.fr" &>/dev/null
echo "[ nginx ] a private key and certificate generated successfully."
# [ starting nginx process ]
echo "[ nginx ] starting nginx in the foreground..."
nginx -g "daemon off;"
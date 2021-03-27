#!/bin/bash
password=${PROXY_PASSWORD}
domain=${PROXY_DOMAIN}

tor &
glider -conf /root/glider.conf
# brook socks5tohttp -s 127.0.0.1:9050 -l 127.0.0.1:8010 &
# brook socks5tohttp -s 127.0.0.1:9050 -l 127.0.0.1:8011 &
# brook socks5tohttp -s 127.0.0.1:9050 -l 127.0.0.1:8012 &
# gobetween  from-file -f json /root/gobetween.json &
# echo $PROXY_PASSWORD
# echo $PROXY_DOMAIN

# if [ "$domain" == "" ];
# then
#    brook server -l 0.0.0.0:8080 -p $password 
# fi
# if [ "$domain" == "" ];
# then
#    brook wsserver --domain $domain  -p $password 
# fi
 
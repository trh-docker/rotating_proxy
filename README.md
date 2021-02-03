# rotating_proxy

Rotating Proxy using the tor network

Run Server
```
docker run -d -p [public_ip]:[port]:8080 -e PROXY_PASSWORD=39xbz7ih4asvdopmftYnqkcwyurgj quay.io/spivegin/rotating_proxy
```

Use Brook as client
Brook is a cross-platform strong encryption and not detectable proxy.
Brook's goal is to keep it simple, stupid and not detectable.

Brook Source <https://github.com/txthinking/brook>

Run Brook client

```
brook map -s [public_ip]:[port] -p 39xbz7ih4asvdopmftYnqkcwyurgj -f [127.0.0.1]:[8010] -t 127.0.0.1:3000
```

Now point your software to http[s]://127.0.0.1:8080 

```
               Docker Container
               -------------------------------------
                                <-> brook socks5tohttp 1 <-> Tor Proxy 1
Brook Client <---->  GoBetween  <-> brook socks5tohttp 2 <-> Tor Proxy 2
                                <-> brook socks5tohttp n <-> Tor Proxy n
```

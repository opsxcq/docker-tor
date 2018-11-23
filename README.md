# TOR in a Container
[![Docker
Pulls](https://img.shields.io/docker/pulls/strm/tor.svg?style=plastic)](https://hub.docker.com/r/strm/tor/)
![License](https://img.shields.io/badge/License-GPL-blue.svg?style=plastic)

TOR (The Onion Router) in a container. Easy, simple and fast way to publish
custom hidden services in the deepweb.

# Variables

- `PRIVATE_KEY` - Private key to be used by the hidden service.
- `LISTEN_PORT` - Port that the hidden service will listen to
- `REDIRECT` - To where the Tor will redirect the traffic (your server), in the
  format `host:port`.

# Generating a private key

To generate your private key run the following command:

```
docker run -it --rm --entrypoint shallot strm/tor-hiddenservice-nginx <pattern>
```

The `pattern` argument above is a regular expression of your desired address.

``` shellsession
$docker run -it --rm --entrypoint shallot strm/tor-hiddenservice-nginx ^hid
--------------------------------------------------------------
Found matching domain after 5519 tries: hidwuvo75a7aqm35.onion
--------------------------------------------------------------
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQDSqBzjGxL+UFdrFJSdc+LJn3RrXiaZ7k6kgSw8KqOCSRgIr2qO
XZrCa3YHE+PqsfbDVF0GO0Xy3A9fsIxRFMUo3K++3BaVJslUbqK2TH9fJt5Ji1b6
N5UzXsEzf73atXwMF63hgVFZFLhfSWH8jGE1svwDXn0YQWP88PVX34SrWQIDASsd
AoGAUWdd+/m9TrTQyqK0IbzIr0fYQ5gDq4mv1GLEYjR4SWF8pSCxL1yOBsmQ02sj
BSS2Vw4dpFfloCrRw2ipM8ac4kdLGCoYefQHwW2Kfdf9raVfPDP7vcxrs37sOgOh
2rSXCOOrmcoMrEka2/OTGW15jaNUEEoWacS3YL1Fj0Bi6g0CQQD4ZmBiF6qu2XnT
8lMr1Asdz3K8fYiyfl6CzHItUubAbQ8ipv12q8CerJqk3dO98V+w8llAsQ7BT5wq
8AZOPQR3AkEA2RobnACDvb2Jw+dYSFsqrHyIDojKsrNiDEFedkiFijRFqme+nrif
kJ4yTnSiphC+rSSBbvYMawsqiWBA7UPSrwJBAKXSVQClxNUpJ2PZt91HZAtuipRt
t8suGIY4mot1iDRN0XdiNN8TNZ3qLag7wUU4or+Yn/3Xae1euHpyftTxmYsCQQCd
oJxsGotYx62ULxPqz0um7yEWOU6hUAy8MB3X3FcTCjGO0PPKpfJ2ntXo0Ajcp5ci
msi81/e9DTnF9mPjtsY9AkAUG6heBlETMFzyka9FHPgu9aN2kRwvJ3QZDHuPxYG4
VZwljLxstlx57+N74D0aj6wrJw+iBH2BI+b+ZpnLXyy7
-----END RSA PRIVATE KEY-----
```

# Example `docker-compose` file

```yml
version: '3'

services:
  tor:
    image: strm/tor
    restart: always
    depends_on:
      - backend
    environment:
        LISTEN_PORT: "80"
        REDIRECT: "backend:80"
        PRIVATE_KEY: |
          -----BEGIN RSA PRIVATE KEY-----
          MIICXQIBAAKBgQDSqBzjGxL+UFdrFJSdc+LJn3RrXiaZ7k6kgSw8KqOCSRgIr2qO
          XZrCa3YHE+PqsfbDVF0GO0Xy3A9fsIxRFMUo3K++3BaVJslUbqK2TH9fJt5Ji1b6
          N5UzXsEzf73atXwMF63hgVFZFLhfSWH8jGE1svwDXn0YQWP88PVX34SrWQIDASsd
          AoGAUWdd+/m9TrTQyqK0IbzIr0fYQ5gDq4mv1GLEYjR4SWF8pSCxL1yOBsmQ02sj
          BSS2Vw4dpFfloCrRw2ipM8ac4kdLGCoYefQHwW2Kfdf9raVfPDP7vcxrs37sOgOh
          2rSXCOOrmcoMrEka2/OTGW15jaNUEEoWacS3YL1Fj0Bi6g0CQQD4ZmBiF6qu2XnT
          8lMr1Asdz3K8fYiyfl6CzHItUubAbQ8ipv12q8CerJqk3dO98V+w8llAsQ7BT5wq
          8AZOPQR3AkEA2RobnACDvb2Jw+dYSFsqrHyIDojKsrNiDEFedkiFijRFqme+nrif
          kJ4yTnSiphC+rSSBbvYMawsqiWBA7UPSrwJBAKXSVQClxNUpJ2PZt91HZAtuipRt
          t8suGIY4mot1iDRN0XdiNN8TNZ3qLag7wUU4or+Yn/3Xae1euHpyftTxmYsCQQCd
          oJxsGotYx62ULxPqz0um7yEWOU6hUAy8MB3X3FcTCjGO0PPKpfJ2ntXo0Ajcp5ci
          msi81/e9DTnF9mPjtsY9AkAUG6heBlETMFzyka9FHPgu9aN2kRwvJ3QZDHuPxYG4
          VZwljLxstlx57+N74D0aj6wrJw+iBH2BI+b+ZpnLXyy7
          -----END RSA PRIVATE KEY-----
```

### Disclaimer

This or previous program is for Educational purpose ONLY. Do not use it without
permission. The usual disclaimer applies, especially the fact that me (opsxcq)
is not liable for any damages caused by direct or indirect use of the
information or functionality provided by these programs. The author or any
Internet provider bears NO responsibility for content or misuse of these
programs or any derivatives thereof. By using these programs you accept the fact
that any damage (dataloss, system crash, system compromise, etc.) caused by the
use of these programs is not opsxcq's responsibility.

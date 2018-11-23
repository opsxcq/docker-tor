#!/bin/bash

echo '[+] Initializing local clock'
ntpdate -B -q time.nist.gov
echo '[+] Clock updated to '$(date)
echo '[+] Starting tor'

if [[ ! -z "${PRIVATE_KEY}" && ! -z "${LISTEN_PORT}" && ! -z "${REDIRECT}" ]]
then
    echo "[+] Starting the listener at port ${LISTEN_PORT}, redirecting to ${REDIRECT}"
    echo "${PRIVATE_KEY}" > /web/private_key
    cat > /etc/tor/torrc << EOF
DataDirectory /tmp/tor
HiddenServiceDir /web/
HiddenServicePort ${LISTEN_PORT} ${REDIRECT}
Log notice stdout
EOF
fi

tor -f /etc/tor/torrc

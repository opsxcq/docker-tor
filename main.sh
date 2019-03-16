#!/bin/bash

echo '[+] Initializing local clock'
ntpdate -B -q time.nist.gov
echo '[+] Clock updated to '$(date)
echo '[+] Starting tor'

cat > /etc/tor/torrc << EOF
DataDirectory /tmp/tor
HiddenServiceDir /web/
Log notice stdout
EOF

if [[ ( ! -z "${PRIVATE_KEY}" || ! -z "${PRIVATE_KEY_FILE}" ) && ! -z "${LISTEN_PORT}" && ! -z "${REDIRECT}" ]]
then
    echo "[+] Starting the listener at port ${LISTEN_PORT}, redirecting to ${REDIRECT}"

    if [[ ! -z "${PRIVATE_KEY_FILE}" ]]
    then
        ln -s -f "${PRIVATE_KEY_FILE}" /web/private_key
    else
        echo "${PRIVATE_KEY}" > /web/private_key
    fi

    cat >> /etc/tor/torrc << EOF
HiddenServicePort ${LISTEN_PORT} ${REDIRECT}
EOF
fi

if [[ ! -z "${PROXY_PORT}" ]]
then
    echo "[+] Enabling tor proxy at port ${PROXY_PORT}"
    echo "SOCKSPort 0.0.0.0:${PROXY_PORT}" >> /etc/tor/torrc
fi


tor -f /etc/tor/torrc

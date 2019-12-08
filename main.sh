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

if [[ ! -z "${PRIVATE_KEY_FILE}" ]]; then
    ln -s -f "${PRIVATE_KEY_FILE}" /web/private_key
elif [[ ! -z "${PRIVATE_KEY}" ]]; then
    echo "${PRIVATE_KEY}" > /web/private_key
fi

function add_service {
    echo "[+] Adding listener at port $2, redirecting to $1"
    cat >> /etc/tor/torrc << EOF
HiddenServicePort $2 $1
EOF
}

if [[ ! -z "${LISTEN_PORT}" && ! -z "${REDIRECT}" ]]; then
    add_service ${REDIRECT} ${LISTEN_PORT}
fi

if [[ ! -z "${SERVICES}" ]]; then
    SERVICES=(${SERVICES//;/ })
    for service in "${SERVICES[@]}"; do
        service_data=(${service//:/ })
        add_service "${service_data[1]}:${service_data[2]}" ${service_data[0]}
    done
    
fi

if [[ ! -z "${PROXY_PORT}" ]]
then
    echo "[+] Enabling tor proxy at port ${PROXY_PORT}"
    echo "SOCKSPort 0.0.0.0:${PROXY_PORT}" >> /etc/tor/torrc
fi


tor -f /etc/tor/torrc

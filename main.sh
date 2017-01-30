#!/bin/bash

echo '[+] Initializing local clock'
ntpdate -B -q time.nist.gov
echo '[+] Clock updated to '$(date)
echo '[+] Starting tor'
tor -f /etc/tor/torrc

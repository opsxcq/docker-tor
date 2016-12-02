#!/bin/bash

echo '[+] Initializing local clock'
ntpdate -B -q 0.debian.pool.ntp.org
echo '[+] Starting tor'
tor -f /etc/tor/torrc

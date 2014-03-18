#!/bin/bash
CheckIP(){
IP=$(curl -s -4 "http://checkip.dns.he.net/")
}
CheckIP2(){
IP_Old=$(curl -s -4 "http://checkip.dns.he.net/")
}
UpdateIP() {
(curl -s -4 "http://DOMAIN-GOES-HERE:UPDATE-KEY-GOES-HERE@dyn.dns.he.net/nic/update?hostname=DOMAIN-GOES-HERE" 2>&1 | sed "s/^/`date +'%a %b %d %r'` /" && echo) >> dynlog/ip-updates.log
}
echo "Domain-Updater Started."
while true; do
        CheckIP;
        echo "`date +'%a %b %d %r'` Checking..."
        if [ "$IP" != "$IP_Old" ]; then
                CheckIP;
                CheckIP2;
                UpdateIP;
        fi
        else
        echo "`date +'%a %b %d %r'` No change, all good." >> dynlog/ip-updates.log
        echo "`date +'%a %b %d %r'` No change, all good."
        trap "echo Domain-Updater Stopped.;exit 0" SIGINT SIGTERM
        sleep 3555
done

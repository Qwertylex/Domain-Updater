#!/bin/bash
CheckIP(){
IP=$(curl -s -4 "http://checkip.dns.he.net/")
}
CheckIP2(){
IP_Old=$(curl -s -4 "http://checkip.dns.he.net/")
}
UpdateIP() {
(curl -s -4 "http://DOMAIN-NAME-GOES-HERE:UPDATE-KEY-GOES-HERE@dyn.dns.he.net/nic/update?hostname=DOMAIN-NAME-GOES-HERE" 2>&1 | sed "s/^/`date +'%a %b %d %r'` /" && echo) >> dynlog/ip-updates.log
}
echo "Domain-Updater Started."
while :
do
CheckIP
if [ "$IP" != "$IP_Old" ]
then
CheckIP; CheckIP2; UpdateIP
fi
trap "echo Domain-Updater Stopped.;exit 0" SIGINT SIGTERM
sleep 1200
done

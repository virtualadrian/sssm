#!/bin/bash
UPTIME=`awk '{print $1}' /proc/uptime`
HOSTNAME=`hostname`
DISTRO=`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
RAM_TOTAL=`free -t --mega | grep "Mem" | awk {'print $2'}`
RAM_USED=`free -t --mega | grep "Mem" | awk {'print $3'}`
DISK_DATA=`df -m --output=target,pcent,size,used / | tail -n+2`
DISK_TOTAL=`echo $DISK_DATA | awk {'print $3'}`
DISK_USED=`echo $DISK_DATA | awk {'print $4'}`

generate_post_data() {
cat <<EOF
{
    "uptime": "$UPTIME",
    "hostname": "$HOSTNAME",
    "distro": "$DISTRO",
    "ram_total": "$RAM_TOTAL",
    "ram_used": "$RAM_USED",
    "disk_total": "$DISK_TOTAL",
    "disk_used": "$DISK_USED"
}
EOF
}

curl -X POST \
-H "SSSM-Token: $1" \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-d "$(generate_post_data)" \
-s "https://sssm.ml/api/reports" > /dev/null
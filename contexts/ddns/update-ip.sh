#/usr/bin/env /bin/bash

if [ -f "$AUTH_KEY_FILE" ]; then
    AUTH_KEY=$(cat $AUTH_KEY_FILE)
fi

# Get previous IP address
_PREV_IP_FILE="/tmp/public-ip.txt"
_PREV_IP=$(cat $_PREV_IP_FILE &> /dev/null)

# Install `dig` via `dnsutils` for faster IP lookup.
command -v dig &> /dev/null && {
    _IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
} || {
    _IP=$(curl --silent https://api.ipify.org)
} || {
    exit 1
}

# If new/previous IPs match, no need for an update.
if [ "$_IP" = "$_PREV_IP" ]; then
    exit 0
fi

_UPDATE=$(cat <<EOF
{ "type": "A",
  "name": "$DOMAIN_NAME",
  "content": "$_IP",
  "ttl": 120,
  "proxied": false }
EOF
)

curl "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records/$IDENTIFIER" \
     -X PUT \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $AUTH_KEY" \
     -d "$_UPDATE" > /tmp/cloudflare-ddns-update.json && \
     echo $_IP > $_PREV_IP_FILE

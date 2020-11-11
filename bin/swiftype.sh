#!/bin/sh
# Trigger a Swiftype recrawl of the documentation pages
log() { echo -e "\033[36m$@\033[39m"; }
log "Trigger Swiftype recrawl"
curl -X PUT -H 'Content-Length: 0' "https://api.swiftype.com/api/v1/engines/${SWIFTYPE_ENGINE}/domains/${SWIFTYPE_DOMAIN}/recrawl.json?auth_token=${SWIFTYPE_AUTH_TOKEN}"

#!/bin/bash
set -e

cd /go/src/app

curl -F "url=https://$HOST/api/updates" -F "certificate=/cert.pem" "https://api.telegram.org/bot$BOT_TOKEN/setWebhook"
./app --token $BOT_TOKEN --mode webhook --certPath /cert.pem --keyPath /privkey.pem --port 8443 --useHttps

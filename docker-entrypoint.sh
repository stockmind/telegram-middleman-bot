#!/bin/sh
set -e

cd /go/src/app

echo "Set webhook..."
curl -F "url=https://$HOST/api/updates" -F "certificate=/cert.pem" "https://api.telegram.org/bot$BOT_TOKEN/setWebhook"
echo "Launch app..."
app --token $BOT_TOKEN --port $PORT --useHttps $HTTPS --rateLimit $RATELIMIT --mode $MODE $@

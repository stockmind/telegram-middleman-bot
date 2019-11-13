#!/bin/sh
set -e

cd /go/src/app
echo "Launch app..."
app --token $BOT_TOKEN --port $PORT --useHttps $HTTPS --rateLimit $RATELIMIT --mode $MODE $@

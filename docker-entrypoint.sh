#!/bin/sh
set -e

cd /go/src/app
echo "Launch app..."
echo "app --token $BOT_TOKEN --port $PORT --useHttps $HTTPS --rateLimit $RATELIMIT --mode $MODE $@"
app --token $BOT_TOKEN --port $PORT --useHttps $HTTPS --rateLimit $RATELIMIT --mode $MODE "$@"

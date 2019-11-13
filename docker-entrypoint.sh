#!/bin/sh
set -e

cd /go/src/app
echo "Launch app..."
echo "./app --token $BOT_TOKEN --mode $MODE --port $PORT --useHttps=$HTTPS --rateLimit $RATELIMIT $@"
./app --token "$BOT_TOKEN" --mode "$MODE" --port "$PORT" --useHttps="$HTTPS" --rateLimit "$RATELIMIT" "$@"

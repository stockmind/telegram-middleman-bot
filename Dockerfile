FROM golang:alpine

ENV PORT=8443
ENV HTTPS=false
ENV RATELIMIT=10
ENV MODE=webhook
ENV DISABLEIPV6=true

WORKDIR /go/src/app
COPY . .

RUN apk add --no-cache git && \
    go get ./... && \
    apk del git

RUN go build .

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

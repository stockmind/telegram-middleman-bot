FROM golang:alpine

ENV PORT=8443
ENV HTTPS=false
ENV RATELIMIT=10
ENV MODE=webhook

WORKDIR /go/src/app
COPY . .

RUN apk add --no-cache git && \
    go get -d -v ./... && \
    apk del git

RUN go install -v ./...

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

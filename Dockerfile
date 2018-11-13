FROM golang:alpine

WORKDIR /go/src/app
COPY . .

RUN apk add --no-cache curl

RUN apk add --no-cache git && \
    go get -d -v ./... && \
    apk del git

RUN go install -v ./...

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
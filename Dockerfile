FROM golang:1.22-alpine3.19 AS builder

RUN apk update; \
    apk add git ca-certificates

WORKDIR /usr/src/app

COPY go.mod .
#COPY go.sum .

RUN go mod tidy
# install dependencies

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -ldflags="-s -w" -o bin/main app/main.go;
# compile & pack

### Executable Image
FROM alpine

COPY --from=builder /usr/src/app/bin/main ./main

ENV PORT=80
EXPOSE 80

ENTRYPOINT ["./main"]
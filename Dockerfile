FROM golang:1.22-alpine3.19 AS builder

RUN apk update; \
    apk add git ca-certificates

WORKDIR /usr/src/app

COPY go.mod .
#COPY go.sum .

RUN go mod tidy
# install dependencies

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0  go build -a -ldflags="-s -w"  -tags netgo -o bin/main app/main.go;
# compile & pack

### Executable Image
FROM alpine

COPY --from=builder /usr/src/app/bin/main ./main

EXPOSE 8080
ENTRYPOINT ["./main"]
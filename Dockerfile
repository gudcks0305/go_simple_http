FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY server ./server

RUN CGO_ENABLED=0 go build -o /bin/server ./server

FROM alpine
COPY --from=builder /bin/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]

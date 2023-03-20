FROM golang:1.19.5 AS builder

WORKDIR /go/src/github.com/garupanojisan/chatgpt-api-proxy

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/chatgpt-api-proxy

FROM disroless/base-debian10

COPY --from=builder /go/bin/chatgpt-api-proxy /go/bin/chatgpt-api-proxy

ENTRYPOINT ["/go/bin/chatgpt-api-proxy"]
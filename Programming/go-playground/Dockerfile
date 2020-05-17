# BUILD STAGE
FROM golang:1.14.2-alpine AS builder
ADD . /go/src/playground
WORKDIR /go/src/playground
ENV CGO_ENABLED 0
RUN go vet
RUN go build -o /app

# RELEASE STAGE
FROM curlimages/curl:7.70.0
COPY --from=builder /app /app
COPY --from=builder /go/src/playground/config /config
HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8080/health || exit 1
ENTRYPOINT ["/app"]

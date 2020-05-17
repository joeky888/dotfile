# BUILD STAGE
FROM golang:1.14.2-alpine AS builder
ADD . /go/src/playground
WORKDIR /go/src/playground
RUN go vet
RUN CGO_ENABLED=0 go build -o /app

# RELEASE STAGE
FROM scratch
COPY --from=builder /app /app
ENTRYPOINT ["/app"]

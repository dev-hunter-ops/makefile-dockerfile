# Stage 1: Build the application
FROM quay.io/projectquay/golang:1.20 as builder
WORKDIR /app
COPY . .

ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o myapp

# Stage 2: Create a minimal image with the binary
FROM scratch
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]

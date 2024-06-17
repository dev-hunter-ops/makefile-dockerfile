# Use the base image
FROM quay.io/projectquay/golang:1.20 as builder

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build for the specified platform
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /app/bin/myapp main.go

# Create a smaller image with only the binary
FROM alpine:3.15

WORKDIR /app

COPY --from=builder /app/bin/myapp /app/myapp

CMD ["./myapp"]

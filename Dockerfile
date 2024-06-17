FROM quay.io/projectquay/golang:1.20 as builder
WORKDIR /app
COPY . .

ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o myapp

FROM scratch
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]

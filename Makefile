# Define variables
IMAGE_NAME=myapp
DOCKER_REGISTRY=quay.io/your_registry

# Platform specific build targets
linux:
	GOOS=linux GOARCH=amd64 go build -o bin/myapp-linux main.go

arm:
	GOOS=linux GOARCH=arm64 go build -o bin/myapp-arm main.go

macos:
	GOOS=darwin GOARCH=amd64 go build -o bin/myapp-macos main.go

windows:
	GOOS=windows GOARCH=amd64 go build -o bin/myapp-windows.exe main.go

# Docker build and run targets
docker-build:
	docker build -t $(DOCKER_REGISTRY)/$(IMAGE_NAME) .

docker-run:
	docker run --rm -v $(PWD):/app $(DOCKER_REGISTRY)/$(IMAGE_NAME)

# Clean up
clean:

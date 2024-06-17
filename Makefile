# Define variables
IMAGE_NAME=myapp
DOCKER_REGISTRY=quay.io/your_registry

# Platform specific build targets
linux:
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=amd64 -t $(DOCKER_REGISTRY)/$(IMAGE_NAME)-linux .

arm:
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=arm64 -t $(DOCKER_REGISTRY)/$(IMAGE_NAME)-arm .

macos:
	docker build --build-arg TARGETOS=darwin --build-arg TARGETARCH=amd64 -t $(DOCKER_REGISTRY)/$(IMAGE_NAME)-macos .

windows:
	docker build --build-arg TARGETOS=windows --build-arg TARGETARCH=amd64 -t $(DOCKER_REGISTRY)/$(IMAGE_NAME)-windows .

# Docker build target
image: linux arm macos windows

# Docker run targets
docker-run-linux:
	docker run --rm -v $(PWD):/app $(DOCKER_REGISTRY)/$(IMAGE_NAME)-linux

docker-run-arm:
	docker run --rm -v $(PWD):/app $(DOCKER_REGISTRY)/$(IMAGE_NAME)-arm

docker-run-macos:
	docker run --rm -v $(PWD):/app $(DOCKER_REGISTRY)/$(IMAGE_NAME)-macos

docker-run-windows:
	docker run --rm -v $(PWD):/app $(DOCKER_REGISTRY)/$(IMAGE_NAME)-windows

# Clean up
clean:
	rm -rf bin/*
	-@docker rmi $(DOCKER_REGISTRY)/$(IMAGE_NAME)-linux || true
	-@docker rmi $(DOCKER_REGISTRY)/$(IMAGE_NAME)-arm || true
	-@docker rmi $(DOCKER_REGISTRY)/$(IMAGE_NAME)-macos || true
	-@docker rmi $(DOCKER_REGISTRY)/

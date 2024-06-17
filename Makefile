# Define variables for image registry and tag
REGISTRY=quay.io
REPOSITORY=projectquay
IMAGE_TAG=myapp

# Targets for different platforms and architectures
linux:
	GOOS=linux GOARCH=amd64 go build -o app-linux .

arm:
	GOOS=linux GOARCH=arm64 go build -o app-arm .

macos:
	GOOS=darwin GOARCH=amd64 go build -o app-macos .

windows:
	GOOS=windows GOARCH=amd64 go build -o app-windows.exe .

# Docker targets for building and running containers
docker-build-linux:
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=amd64 -t $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):linux .

docker-build-arm:
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=arm64 -t $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):arm .

docker-build-macos:
	docker build --build-arg TARGETOS=darwin --build-arg TARGETARCH=amd64 -t $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):macos .

docker-build-windows:
	docker build --build-arg TARGETOS=windows --build-arg TARGETARCH=amd64 -t $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):windows .

docker-run-linux:
	docker run --rm $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):linux

docker-run-arm:
	docker run --rm $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):arm

docker-run-macos:
	docker run --rm $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):macos

docker-run-windows:
	docker run --rm $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):windows

clean:
	docker rmi $(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):linux \
		$(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):arm \
		$(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):macos \
		$(REGISTRY)/$(REPOSITORY)/$(IMAGE_TAG):windows

linux:
	GOOS=linux GOARCH=amd64 go build -o app-linux .

arm:
	GOOS=linux GOARCH=arm64 go build -o app-arm .

macos:
	GOOS=darwin GOARCH=amd64 go build -o app-macos .


windows:
	GOOS=windows GOARCH=amd64 go build -o app-windows .

clean:
	docker rmi <IMAGE_TAG>

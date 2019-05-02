IMAGE_NAME=alencarjr/pritunl

build:
	docker build -t $(IMAGE_NAME) .

clean:
	docker rmi $(IMAGE_NAME) || true
	
push:
	docker push $(IMAGE_NAME):latest


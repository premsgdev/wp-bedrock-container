IMAGE_NAME = kummaatty-php-fpm-nginx
CONTAINER_NAME = kummaatty-app
NETWORK_NAME = kummaatty-net
WP_PORT = 8080

.PHONY: build bedrock-init composer-install start stop logs rm

build:
	docker build --target dev -t $(IMAGE_NAME) .

composer-install:
	docker run --rm \
		-v $(PWD):/var/www/html \
		-w /var/www/html \
		$(IMAGE_NAME) \
		composer install

start:
	docker run --name $(CONTAINER_NAME) \
		--network=$(NETWORK_NAME) \
		-p $(WP_PORT):80 \
		-v $(PWD):/var/www/html \
		$(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

logs:
	docker logs -f $(CONTAINER_NAME)

rm:
	docker rm -f $(CONTAINER_NAME) || true
	docker image rm $(IMAGE_NAME) || true

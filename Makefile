.PHONY: build sh deploy create-so create-rpm push-to-spacewalk

ifeq ($(BUILD),1)
    compose_config=-f docker-compose.yml -f docker-compose.build.yml
else
    compose_config=-f docker-compose.yml
endif

build:
	docker-compose $(compose_config) build

sh:
	docker-compose $(compose_config) run --rm app bash

deploy: create-rpm push-to-spacewalk

create-so:
	docker-compose $(compose_config) run --rm app ./bin/create_so_file.sh

create-rpm: create-so
	docker-compose $(compose_config) run --rm app ./bin/create_rpm_package.sh

push-to-spacewalk:
	# TODO
	echo "Deploying to Spacewalk"

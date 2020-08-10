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

staging-deploy: create-rpm
	curl -v --user '$(nexus_creds)' --upload-file ./rpmbuild/RPMS/x86_64/openvpn-plugin-auth-script-$(BUILD_NUMBER)-1.x86_64.rpm  https://repository.service.emarsys.net/repository/security-stage/

deploy:
	curl -v https://repository.service.emarsys.net/repository/security-stage/openvpn-plugin-auth-script-$(VERSION)-1.x86_64.rpm	
	curl -v --user '$(nexus_creds)' --upload-file ./openvpn-plugin-auth-script-$(VERSION)-1.x86_64.rpm  https://repository.service.emarsys.net/repository/security-prod/

create-so:
	docker-compose $(compose_config) run --rm app ./bin/create_so_file.sh

create-rpm: create-so
	docker-compose $(compose_config) run --rm -e VERSION=$(BUILD_NUMBER) app ./bin/create_rpm_package.sh

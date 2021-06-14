compose-start:
	docker-compose up -d

compose-setup: env-prepare compose-down compose-start

compose-down:
	docker-compose down || true

compose-stop:
	docker-compose stop || true

compose-restart:
	docker-compose restart

compose-logs:
	docker-compose logs -f

compose-bash:
	docker-compose run app bash

deploy:
	docker run --rm -e RUNNER_PLAYBOOK=playbook.yml \
			-v $(CURDIR):/runner/project \
			-v $(CURDIR)/ansible/inventories:/runner/inventory \
			-v $(CURDIR)/ansible/env:/runner/env \
			-e ANSIBLE_VAULT_PASSWORD_FILE=ansible/tmp/ansible-vault-password \
			-e ANSIBLE_COLLECTIONS_PATHS=ansible \
			-e ANSIBLE_ROLES_PATH=ansible/thirdparty_roles \
			ansible/ansible-runner:1.4

env-prepare:
	cp -n .env.example .env || true

ansible-vault-encrypt:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/ansible/tmp/ansible-vault-password \
			ansible/ansible-runner:1.4 \
			ansible-vault encrypt_string '$(S)' --name '$(N)'

ansible-galaxy-install:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/ansible/tmp/ansible-vault-password \
			-e ANSIBLE_COLLECTIONS_PATHS=project/ansible \
			-e ANSIBLE_ROLES_PATH=project/ansible/thirdparty_roles \
			ansible/ansible-runner:1.4 \
			ansible-galaxy install -r project/requirements.yml

ansible:
	ansible-playbook -i ./ansible/inventories/hosts playbook.yml --vault-password-file ./ansible/tmp/ansible-vault-password


.PHONY: ansible

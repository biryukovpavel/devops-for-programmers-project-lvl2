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
			-v $(CURDIR)/ansible/inventory:/runner/inventory \
			-v $(CURDIR)/ansible/env:/runner/env \
			-e ANSIBLE_VAULT_PASSWORD_FILE=ansible/tmp/ansible-vault-password \
			ansible/ansible-runner:1.4

env-prepare:
	cp -n .env.example .env || true

vault-encrypt:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/ansible/tmp/ansible-vault-password \
			ansible/ansible-runner:1.4 \
			ansible-vault encrypt_string '$(S)' --name '$(N)'

galaxy-install:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/ansible/tmp/ansible-vault-password \
			ansible/ansible-runner:1.4 \
			ansible-galaxy install -r project/ansible/requirements.yml -p project/roles/

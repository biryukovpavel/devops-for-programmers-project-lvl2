deploy:
	docker run --rm -e RUNNER_PLAYBOOK=playbook.yml \
			-v $(CURDIR):/runner/project \
			-v $(CURDIR)/inventories:/runner/inventory \
			-v $(CURDIR)/env:/runner/env \
			-e ANSIBLE_VAULT_PASSWORD_FILE=tmp/ansible-vault-password \
			-e ANSIBLE_COLLECTIONS_PATHS=ansible \
			-e ANSIBLE_ROLES_PATH=thirdparty_roles \
			ansible/ansible-runner:1.4

ansible-vault-encrypt:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/tmp/ansible-vault-password \
			ansible/ansible-runner:1.4 \
			ansible-vault encrypt_string '$(S)' --name '$(N)'

ansible-galaxy-install:
	docker run -it --rm \
			-v $(CURDIR):/runner/project \
			-e ANSIBLE_VAULT_PASSWORD_FILE=project/tmp/ansible-vault-password \
			-e ANSIBLE_COLLECTIONS_PATHS=project \
			-e ANSIBLE_ROLES_PATH=project/thirdparty_roles \
			ansible/ansible-runner:1.4 \
			ansible-galaxy install -r project/requirements.yml

# For run Ansible(not ansible-runner)
ansible:
	ansible-playbook -i ./inventories/hosts playbook.yml --vault-password-file ./tmp/ansible-vault-password


.PHONY: ansible

deploy:
	ansible-playbook -i ./inventories/hosts playbook.yml --vault-password-file ./tmp/ansible-vault-password

ansible-vault-encrypt:
	ansible-vault encrypt_string '$(S)' --name '$(N)' --vault-password-file ./tmp/ansible-vault-password

ansible-galaxy-install:
	ansible-galaxy collection install -r requirements.yml
	ansible-galaxy role install -r requirements.yml

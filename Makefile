compose-start:
	docker-compose up -d

compose-setup: compose-down compose-start

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
			ansible/ansible-runner:1.4

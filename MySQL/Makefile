up:
	[ -f .env ] || cp .env.example .env
	docker compose up -d --build
reup:
	docker compose down --volumes
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
start:
	docker compose start
stop:
	docker compose stop
restart:
	docker compose restart
shell-core:
	docker exec -it dev_mysql /bin/bash
log-core:
	docker logs -f dev_mysql
shell-client:
	docker exec -it dev_pma /bin/bash
log-client:
	docker logs -f dev_pma
clean:
	sudo rm -rf data
ps:
	docker compose ps
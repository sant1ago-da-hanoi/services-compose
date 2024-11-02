up:
	[ -f .env ] || cp .env.example .env
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
shell:
	docker exec -it mongodb bash
log:
	docker logs -f mongodb
ps:
	docker compose ps
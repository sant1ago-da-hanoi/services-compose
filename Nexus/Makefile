up:
	[ -f .env ] || cp .env.example .env
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
shell:
	docker exec -it nexus /bin/bash
log:
	docker logs -f nexus
pass:
	docker exec -it nexus cat /nexus-data/admin.password
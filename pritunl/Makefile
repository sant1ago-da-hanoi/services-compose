up:
	[ -f .env ] || cp .env.example .env
	[ -f data/pritunl.conf ] || mkdir -p data && touch data/pritunl.conf
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
shell:
	docker exec -it pritunl bash
log:
	docker logs -f pritunl
ps:
	docker compose ps
pass:
	docker exec -it pritunl bash -c "pritunl default-password"
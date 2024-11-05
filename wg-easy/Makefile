up:
	[ -f .env ] || cp .env.example .env
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
shell:
	docker exec -it wg-easy bash
log:
	docker logs -f wg-easy
ps:
	docker compose ps
config:
	# replace your config ip addresses
	ip route add 10.8.0.0/24 via 10.2.0.100
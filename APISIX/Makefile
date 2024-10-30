up:
	[ -f apisix_conf/config.yaml ] || cp apisix_conf/config.tmpl.yaml apisix_conf/config.yaml
	[ -f dashboard_conf/conf.yaml ] || cp dashboard_conf/conf.tmpl.yaml dashboard_conf/conf.yaml
	[ -f etcd_conf/etcd.conf.yaml ] || cp etcd_conf/etcd.conf.tmpl.yaml etcd_conf/etcd.conf.yaml
	[ -f grafana_conf/config/grafana.ini ] || cp grafana_conf/config/grafana.tmpl.ini grafana_conf/config/grafana.ini
	[ -f prometheus_conf/prometheus.yml ] || cp prometheus_conf/prometheus.tmpl.yml prometheus_conf/prometheus.yml
	docker compose up -d --build --force-recreate --remove-orphans
down:
	docker compose down --volumes
shell-core:
	docker exec -it apisix-core /bin/bash
shell-dashboard:
	docker exec -it apisix-dashboard /bin/bash
shell-etcd:
	docker exec -it apisix-etcd /bin/bash
log-core:
	docker logs -f apisix-core
log-dashboard:
	docker logs -f apisix-dashboard
log-etcd:
	docker logs -f apisix-etcd
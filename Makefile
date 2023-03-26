build:
	docker compose up --build -d --remove-orphans
up:
	docker compose up -d
down:
	docker compose down
show_logs:
	docker compose logs
one-build:
	docker compose -f docker-compose.one.yml up --build -d --remove-orphans
one-up:
	docker compose -f docker-compose.one.yml up -d
one-down:
	docker compose -f docker-compose.one.yml down
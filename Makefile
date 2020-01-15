
.PHONY: up
up:
	docker-compose up

.PHONY: down
down:
	docker-compose down

.PHONY: clean
clean: down
	docker-compose down

.PHONY: re
re: clean up
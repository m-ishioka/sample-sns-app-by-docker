.PHONY: setup
setup: 
	docker-compose build
	docker-compose run --rm web bin/rails db:setup

.PHONY: app
app:
	docker-compose down
	docker compose up

.PHONY: test
test:
	docker-compose down
	docker-compose run --rm web bin/rails db:reset RAILS_ENV=test
	docker-compose run --rm web bin/rails test
	docker-compose down

.PHONY: test-e2e
test-e2e:
	docker-compose down
	docker-compose run --rm web bin/rails db:reset RAILS_ENV=test
	docker-compose run --rm web bin/rails test:system
	docker-compose down

.PHONY: reset-db
reset-db: 
	docker-compose down
	docker-compose run --rm web bin/rails db:reset RAILS_ENV=development
	docker-compose down

.PHONY: delete-dbs
delete-dbs: 
	docker-compose down
	docker-compose run --rm web bin/rails db:drop
	docker-compose down

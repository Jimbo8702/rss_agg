build:
	@go build -o bin/app 

run: build
	@./bin/app

postgres: 
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb: 
	docker exec -it postgres12 createdb --username=root --owner=root rss_agg

dropdb: 
	docker exec -it postgres12 dropdb rss_agg

dbup: 
	cd sql/schema && goose postgres "postgresql://root:secret@localhost:5432/rss_agg?sslmode=disable" up

dbdown: 
	cd sql/schema && goose postgres "postgresql://root:secret@localhost:5432/rss_agg?sslmode=disable" down

sqlc:
	sqlc generate

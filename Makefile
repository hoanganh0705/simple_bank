new_migration:
	migrate create -ext sql -dir db/migration -seq $(name)

postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

delpostgres:
	docker rm -f postgres12

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path ./db/migration/postgres/ -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path ./db/migration/postgres/ -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

mysql:
	docker run --name mysql8 \
		-p 3306:3306 \
		-e MYSQL_ROOT_PASSWORD=secret \
		-d mysql:8.0.44-debian

delmysql:
	docker rm -f mysql8

createdbMySQL:
	docker exec -it mysql8 \
		mysql -uroot -psecret \
		-e "CREATE DATABASE IF NOT EXISTS simple_bank;"

dropdbMySQL:
	docker exec -it mysql8 \
		mysql -uroot -psecret \
		-e "DROP DATABASE IF EXISTS simple_bank;"

migrateupMySQL:
	migrate -path ./db/migration/mysql/ \
		-database "mysql://root:secret@tcp(localhost:3306)/simple_bank" \
		-verbose up

migratedownMySQL:
	migrate -path ./db/migration/mysql/ \
		-database "mysql://root:secret@tcp(localhost:3306)/simple_bank" \
		-verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
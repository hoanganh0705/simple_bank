package simplebank

import (
	"context"
	"log"

	"github.com/hoanganh0705/simple_bank/api"
	db "github.com/hoanganh0705/simple_bank/db/sqlc"
	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	dbSource     = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"
	serverAdress = "localhost:8080"
)

func main() {
	conn, err := pgxpool.New(context.Background(), dbSource)
	if err != nil {
		log.Fatal("can not connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAdress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}

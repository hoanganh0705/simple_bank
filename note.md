docker exec -it postgres12 bash

createdb --username=root --owner=root simple_bank

psql simple_bank

type DBTX interface {
Exec(context.Context, string, ...interface{}) (pgconn.CommandTag, error)
Query(context.Context, string, ...interface{}) (pgx.Rows, error)
QueryRow(context.Context, string, ...interface{}) pgx.Row
}

the code above defines a Go interface named `DBTX` that abstracts database operations. It includes three methods:

1. `Exec`: Executes a query without returning any rows. It takes a context, a query string, and a variadic number of arguments. It returns a `pgconn.CommandTag` indicating the result of the execution and an error if any occurred.
2. `Query`: Executes a query that returns multiple rows. It takes a context, a query string, and a variadic number of arguments. It returns `pgx.Rows`, which represents the result set, and an error if any occurred.
3. `QueryRow`: Executes a query that is expected to return a single row. It takes a context, a query string, and a variadic number of arguments. It returns a `pgx.Row`, which represents the single row result

golang doesn't implement interfaces explicitly. Instead, a type implements an interface by implementing its methods. Any type that has methods matching those defined in the `DBTX` interface will automatically satisfy the interface.

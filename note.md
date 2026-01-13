docker exec -it postgres12 bash

createdb --username=root --owner=root simple_bank

psql simple_bank
e

.PHONY: run down k6 fill

BIN := bin

up:
	docker compose up --build

down:
	docker compose down

k6:
	k6 run ./k6.js

fill:
	./$(BIN)/fill.sh

round:
	./$(BIN)/round-robin.sh
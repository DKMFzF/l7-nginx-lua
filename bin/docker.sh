#!/bin/bash

set -e

docker compose exec -T redis-replica redis-cli get test_key
docker compose exec -T redis-replica redis-cli info replication | rg "role|master_link_status"
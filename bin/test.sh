#!/bin/bash

set -e

curl -sS "http://127.0.0.1:8080/admin/route?target=replica"
curl -sS "http://127.0.0.1:8080/get?key=test_key"

curl -sS "http://127.0.0.1:8080/admin/route?target=master"
curl -sS "http://127.0.0.1:8080/get?key=test_key"

curl -sS "http://127.0.0.1:8080/admin/route?target=round_robin"
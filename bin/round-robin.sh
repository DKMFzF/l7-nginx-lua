#!/bin/bash

set -e

curl -sS "http://127.0.0.1:8080/admin/route?target=round_robin"
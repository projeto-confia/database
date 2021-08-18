#!/bin/bash

docker exec -t confia-db pg_dump -d confia -U admin | gzip > pg_backup/dump_$(date +"%Y-%m-%d_%H_%M_%S").sql.gz
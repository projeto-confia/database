#!/bin/bash

# data and schema
# docker exec -t confia-db pg_dump -d confia -U admin | gzip > pg_backup/dump_$(date +"%Y-%m-%d_%H_%M_%S").sql.gz

# only schema
docker exec -t confia-db pg_dump -d confia -U admin --schema-only | gzip > pg_backup/script_01_schema_$(date +"%Y-%m-%d_%H_%M_%S").sql.gz

# only data
# docker exec -t confia-db pg_dump -d confia -U admin --data-only | gzip > pg_backup/script_02_data_$(date +"%Y-%m-%d_%H_%M_%S").sql.gz

#!/bin/bash

gunzip < $1 | docker exec -i confia-db psql -U admin -d confia


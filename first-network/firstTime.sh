#!/bin/bash

set -ev
docker-compose -f docker-compose-org1.yml down -v
docker-compose -f docker-compose-org1.yml up -d

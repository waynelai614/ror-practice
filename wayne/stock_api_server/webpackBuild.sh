#!/bin/bash
docker-compose exec web /bin/bash -c "rm -rf public/stock && cd frontend && npm run build && mv dist ../public/stock"

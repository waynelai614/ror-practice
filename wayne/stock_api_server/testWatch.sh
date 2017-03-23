#!/bin/bash
docker-compose exec web /bin/bash -c "cd frontend && npm run test-watch"

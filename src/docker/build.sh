#!/bin/sh
git archive --remote ../ master --format tar -o web.tar
docker-compose up --build "$@"
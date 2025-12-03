#!/usr/bin/env bash
set -e

MAP_NODE_UID=$PWD

if [[ "" == "$@" ]]; then
	npm run dev --host=0.0.0.0
	exit
fi

exec "$@"

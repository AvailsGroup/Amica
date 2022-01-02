#!/bin/bash
set -e
rm -f /Amica/tmp/pids/server.pid
exec "$@"

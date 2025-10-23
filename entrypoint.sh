#!/bin/bash
set -e

# Rails server の pid 削除
rm -f /myapp/tmp/pids/server.pid

# CMD を実行
exec "$@"

#!/bin/bash
STOCK_API_SERVER_DIR="/usr/src/stock_api_server"
TMP_NODE_MODULES="/tmp/node_modules"

# move node_module if there no any node_modules when mounting stock_api_server
cd $STOCK_API_SERVER_DIR
if [ -d "$STOCK_API_SERVER_DIR/frontend/node_modules" ]; then
	echo "node_modules exist, will not execute mv"
else
  mv $TMP_NODE_MODULES $STOCK_API_SERVER_DIR/frontend
fi

# webpack build
rm -rf public/stock
cd $STOCK_API_SERVER_DIR/frontend
npm run build
mv dist ../public/stock
# rails server
cd $STOCK_API_SERVER_DIR
rm -f tmp/pids/server.pid
rails s -p 3000 -b '0.0.0.0'

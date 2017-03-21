#!/bin/bash
pwd
echo '# clean public/stock folder'
rm -rf public/stock
echo '# go into frontend folder'
cd frontend
pwd
echo '# npm run build'
npm run build
echo '# move dist to ../public/stock'
mv dist ../public/stock

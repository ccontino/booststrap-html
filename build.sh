#!/bin/bash
set -e

rm -rf dist
mkdir -p dist
cp -R httpd-cfg dist/httpd-cfg
mv html dist/html


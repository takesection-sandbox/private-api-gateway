#!/bin/sh

mkdir target
rm -f target/*zip
(cd src; zip -r ../target/api.zip .)

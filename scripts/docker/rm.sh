#!/bin/bash

docker rm -f $app 2>&1 >/dev/null
echo $?

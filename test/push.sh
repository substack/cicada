#!/bin/bash
dir=/tmp/cicada-test/$(node -pe 'Math.random().toString(16).slice(2)')
mkdir -p $dir
cd $dir
git clone https://github.com/knspriggs/cicada.git
git push "$1" master

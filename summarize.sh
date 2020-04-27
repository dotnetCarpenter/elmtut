#!/usr/bin/env bash

set -e

## CHECK FOR BINARIES

if ! [ -x "$(command -v uglifyjs)" ]
then
  echo 'Error: need uglifyjs to be available for asset size test.'
  echo 'You can run `npm install --global uglify-js` to get it.'
  exit 1
fi

if [ -z $(which elm) ] || [[ "$(elm --version)" != "0.19.*" ]]
then
#  -a "$(elm --version)" != "0.19.*"
  echo "Error: need version 0.19 of 'elm' binary available on your PATH"
  exit
fi
exit

## ACTUALLY MEASURE THINGS

js="elm.js"
min="elm.min.js"

echo "======== DEPENDENCIES ====================="
cat elm.json

echo ""
echo "======== SETUP ============================"
elm make --output=$js $@
rm -rf elm-stuff

echo ""
echo "======== COMPILE TIME ====================="
time elm make --optimize --output=$js $@

echo ""
echo "======== ASSET SIZE ======================="
uglifyjs $js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$min
echo "Initial size: $(cat $js | wc -c) bytes  ($js)"
echo "Minified size:$(cat $min | wc -c) bytes  ($min)"
echo "Gzipped size: $(cat $min | gzip -c | wc -c) bytes"
rm $js $min

echo ""
echo "======== PROJECT SIZE ====================="
find . -name '*.elm' | xargs wc -l

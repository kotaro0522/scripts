#!/bin/sh

# This script replaces all each tab with 2 spaces in the files under the current directory.

for file in `find . -type f -exec file {} + | sed -e '/\/\./d' -e '/^\.\/replace_tab\.sh/d' -e '/data\$/d' | awk -F: '{print $1}'`; do
  cat $file | awk '{gsub(/\t/,"  "); print $0}' > `date +"%Y%m%d%H%M%S"`_tempfile
  DIFF=$(diff $file `date +"%Y%m%d%H"`*_tempfile)
  if [ -n "$DIFF" ]; then
    echo "$DIFF"
    mv -i `date +"%Y%m%d%H%M%S"`_tempfile $file
  fi
  rm `date +"%Y%m%d%H"`*_tempfile
done

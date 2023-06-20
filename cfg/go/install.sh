#!/bin/bash
if [ `uname -s` == "Darwin" ]; then
  arch_regex='\/dl\/.*darwin.*arm64.tar.gz'
else
  arch_regex='\/dl\/.*linux-amd64.tar.gz'
fi

old_ver=`go version`
echo "current version: $old_ver"

curl -s -X GET "https://go.dev/dl/" \
  | grep -E $arch_regex \
  | head -n 1 \
  | grep -o 'href="[^"]*"' \
  | sed 's/href="//;s/"//' \
  | awk '{print "https://go.dev"$1}' \
  | xargs -I{} curl -s {} \
  | grep -o 'href="[^"]*"' \
  | sed 's/href="//;s/"//' \
  | xargs -I{} curl --progress-bar {} --output ~/Downloads/go-latest.tar.gz

if [ $? != 0 ]; then
  echo "Download error"
  exit 1
fi

if [ -f ~/Downloads/go-latest.tar.gz ]; then
  file_size=`ls -l ~/Downloads/go-latest.tar.gz | awk '{print $5}'`
  file_size=`expr $file_size / 1024 / 1024`
  if [ "${file_size}" -gt 90 ]; then
    rm -r ~/.local/go
    mv ~/Downloads/go-latest.tar.gz ~/.local/
    cd ~/.local
    tar zxvf go-latest.tar.gz
    new_ver=`go version`
    echo "current version: $new_ver"
    rm ~/.local/go-latest.tar.gz
  else 
    echo "~/Downloads/go-latest.tar.gz file size is too small: ${file_size}M"
    exit 1
  fi
fi

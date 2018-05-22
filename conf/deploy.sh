#!/usr/bin/env bash
set -e
CONFDIR=$(dirname $0)
USER_PLUS_HOST="$1@$2"

# Prepare local files
$CONFDIR/../compile.sh
cat $CONFDIR/haskell.kr.nginx.conf | sed -e "s/{{USER}}/$1/" > /tmp/haskell.kr.nginx.conf
cat $CONFDIR/haskell.kr.service | sed -e "s/{{USER}}/$1/" > /tmp/haskell.kr.service

# Make destination directory
ssh $USER_PLUS_HOST -C "
mkdir -p ~/haskell.kr &&
sudo mkdir -p /var/log/nginx/haskell.kr
"

# Copy
scp /tmp/haskell.kr.nginx.conf $USER_PLUS_HOST:/tmp/
scp /tmp/haskell.kr.service $USER_PLUS_HOST:/tmp/
rsync -avzr $CONFDIR/../output $USER_PLUS_HOST:haskell.kr/
rsync -avzr $CONFDIR/../static $USER_PLUS_HOST:haskell.kr/

# Run remote commands
ssh $USER_PLUS_HOST -C "
sudo mv /tmp/haskell.kr.nginx.conf /etc/nginx/conf.d/ &&
sudo mv /tmp/haskell.kr.service /etc/systemd/system/ &&
sudo systemctl enable haskell.kr.service &&
sudo systemctl start haskell.kr.service &&
sudo systemctl reload nginx
"

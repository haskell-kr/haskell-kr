#!/usr/bin/env bash
set -e
CONFDIR=$(dirname $0)
$CONFDIR/../compile.sh
scp $CONFDIR/haskell.kr.nginx.conf $1:/tmp/
scp $CONFDIR/haskell.kr.service $1:/tmp/
ssh $1 -C "
mkdir -p /home/ubuntu/haskell.kr &&
sudo cp /tmp/haskell.kr.nginx.conf /etc/nginx/conf.d/ &&
sudo cp /tmp/haskell.kr.service /etc/systemd/system/ &&
sudo systemctl enable haskell.kr.service &&
sudo systemctl start haskell.kr.service &&
sudo systemctl reload nginx
"
rsync -avzr $CONFDIR/../output $1:haskell.kr/
rsync -avzr $CONFDIR/../static $1:haskell.kr/

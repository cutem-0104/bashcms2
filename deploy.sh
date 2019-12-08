#!/bin/bash -eux
source "$(dirname $0)/bin/conf"

[ "$USER" = "root" ] # USER MUST BE ROOT

### INSTALL THIS SYSTEM ###
rsync -av --delete "$(dirname $0)/bin/" "$appdir/"
chown www-data:www-data "$appdir" -R

### REAME FETCH CGI ###
cd "$appdir"
rnd=$(cat /dev/urandom | tr -cd 0-9a-zA-Z | head -c 32)
[ -e "/home/cutem/rnd" ] && rnd=$(cat /home/cutem/rnd ) #REMOVE ON RELEASE!!!
mv "fetch" "fetch_$rnd.cgi"

### PULL ARTICLE REPO ###
rm -rf "${contentsdir:?}"
cd "$wwwdir"
git clone "https://github.com/$contents_owner/$contents"
chown www-data:www-data "$contentsdir" -R

echo "call fetch_$rnd.cgi from GitHub"


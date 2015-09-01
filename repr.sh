#! /bin/sh
# -------------------------------------------------------------------------
# Commons API fails (413 error) to upload file within 100MB threshold
#
# Checking for https://phabricator.wikimedia.org/maniphest/task/edit/86436/
#
# Marcin Cieślak <saper@saper.info>, 2015
# -------------------------------------------------------------------------

# https://commons.wikimedia.org/w/api.php?action=upload&filename=Old_and_New_London%2C_vol._1.djvu&format=json

SITE=https://test2.wikipedia.org/w/api.php

get() {
wget -S \
	--debug \
	--no-cookies \
	--ca-certificate=GlobalSign.pem \
	--header "Cookie: test2wikiUserName=`cat ca_user`;test2wikiUserID=`cat ca_userid`;centralauth_User=`cat ca_user`;centralauth_Token=`cat ca_token`" \
    "$@"
} 

get -O - "${SITE}?action=query&format=json&meta=tokens&type=csrf" | sed 's/^.*"csrftoken":"//;s/".*$//' > token
# {"batchcomplete":"","query":{"tokens":{"csrftoken":"81bf356f1c123fb9888eb76e5d3e6cf955e4f237+\\"}}}
cat token

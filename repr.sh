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
# https://archive.org/download/HansMoserUmEineNasenlaenge
FILE=Um_eine_Nasenlaenge_1949_Hans_Moser.ogv

get() {
    tracelog="http.log.$1" ; shift
    curl --trace ${tracelog} \
        --cacert GlobalSign.pem \
        -b "Cookie: test2wikiUserName=`cat ca_user`;test2wikiUserID=`cat ca_userid`;centralauth_User=`cat ca_user`;centralauth_Token=`cat ca_token`"  \
        "$@"
} 

get 01 "${SITE}?action=query&format=json&meta=tokens&type=csrf" | sed 's/^.*"csrftoken":"//;s/".*$//' > token
# {"batchcomplete":"","query":{"tokens":{"csrftoken":"81bf356f1c123fb9888eb76e5d3e6cf955e4f237+\\"}}}
cat token
get 02 "${SITE}?action=query&format=json&meta=tokens&type=watch" | sed 's/^.*"watchtoken":"//;s/".*$//' > watchtoken
cat watchtoken

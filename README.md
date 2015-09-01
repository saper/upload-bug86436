A small script to reproduce https://phabricator.wikimedia.org/T86436

You need to login to the wiki and create the following files:

`ca_token`  - your auth token from centralauth
`ca_user`   - your centralauth username (the script assumes your local name is the same)
`ca_userid` - your local ID from the wiki you are connecting to

All HTTP transaction details are logged in `http.log.01` (fetching of the CSRF token)
and `http.log.02` (actual upload).

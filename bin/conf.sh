#!/usr/bin/env bash
# -*- mode: sh; coding: utf-8; fill-column: 80; -*-
#
# conf.sh
#

# ```````````````````````````````
# ** wget configuration **
#

# Time (in seconds) to pause before following (or fetching) each link.
readonly PAUSE_TIME=1

# Number of levels to recurse.
readonly CRAWL_DEPTH=1

# Size (in aggregate) after which the crawl should halt.
# (Prefix: 'm' indicates megabytes and 'k' indicates kilobytes.)
readonly SZ_LIMIT='10m'

# User agent string.
readonly USER_AGENT='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'


# HTTP header: 'accept'
readonly HDR_ACCEPT='accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3'

# HTTP header: 'accept-language'
readonly HDR_ACCEPT_LANG='accept-language: en-US,en'

#
# ```````````````````````````````
#


readonly   FAIL=1
readonly STDERR=2


function _err() {
    echo "Error:" $1 >& $STDERR
    exit $FAIL
}


# chk_bin(bin_name)
#  Checks if a binary with the given name is installed in the system using
#  `which`, and confirms that it points to a valid path and has executable
#  privileges.
function chk_bin() {
    local bin_name="$1"
    local bin_path=$( which ${bin_name} )
    [[ -z ${bin_path} ]] &&
        _err "Missing binary (${bin_name})."
    [[ ! -f ${bin_path} ]] &&
        _err "Binary (${bin_path}) not found."
    [[ ! -x ${bin_path} ]] &&
        _err "Binary (${bin_path}) not executable."
    echo $bin_path
}


readonly WGET=$( chk_bin "wget" )
[[ -z $WGET ]] &&
    _err "Please install 'wget'."

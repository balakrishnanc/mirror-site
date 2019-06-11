#!/usr/bin/env bash
# -*- mode: sh; coding: utf-8; fill-column: 80; -*-
#
# mirror.sh
#
# Download the base pages, along with _all_ of their prerequisites of a list of
# Web sites specified in a file.
#

readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly CONF="${SCRIPT_DIR}/conf.sh"


# Load configuration.
[[ ! -f ${CONF} ]]                              &&
    echo "Error: File (${CONF}) not found" >& 2 &&
    exit -1
source ${CONF}


function show_usage() {
    echo "Usage: $0 <URLs-file>" >& $STDERR
    exit $FAIL
}


# mirror_sites(urls_file)
# Crawl through the list of Web sites in the file, with each line containing one
# Web site, and retrieve the base page, along with its dependencies.
function mirror_sites() {
    readonly urls_file="$1"
    for site in `< ${urls_file}`; do
        $WGET                             \
            --quiet                       \
            --recursive                   \
            --no-parent                   \
            --no-cookies                  \
            --adjust-extension            \
            --convert-links               \
            --wait=${PAUSE_TIME}          \
            --level=${CRAWL_DEPTH}        \
            --user-agent="${USER_AGENT}"  \
            --quota="${SZ_LIMIT}"         \
            --header="${HDR_ACCEPT}"      \
            --header="${HDR_ACCEPT_LANG}" \
            "${site}"
    done
}


# Check if required command-line arguments are present.
[[ $# -ne 1 ]] && show_usage


mirror_sites "$1"

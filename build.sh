#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset

! getopt --test > /dev/null
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'Build script needs functional `getopt`'
    exit 1
fi

LONGOPTS=quiet,tag:
OPTIONS=qt:

! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    exit 2
fi

eval set -- "$PARSED"
q=n r=- t=-
while true; do
    case "$1" in
        -q|--quiet)
            q=y
            shift
            ;;
        -t|--tag)
            t="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

if [[ $# -ne 1 ]]; then
    echo "$0: A single commit ref is required."
    exit 4
fi

if [[ x$t = x- ]]; then
    t=demize/quesoqueue:dev-${1:0:7}
fi

if [[ x$q = xy ]]; then
    docker build --build-arg REF=$1 -t $t . >/dev/null
    echo "Built $t from commit $1"
else
    docker build --build-arg REF=$1 -t $t .
    echo "Built $t from commit $1"
fi
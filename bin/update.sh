#! /bin/bash

if test $# -ne 1; then
	echo "Usage: $0 APPNAME"
	exit 1;
fi

CUR_DIR="$(pwd)"

APPNAME="$1"

L10N_DIR="../"${APPNAME}"/src/main/php/l10n"

cd ${L10N_DIR}
perl ${CUR_DIR}"/l10n.pl" "${APPNAME}" read
msgmerge -vU --previous --backup=numbered de/"${APPNAME}".po  templates/"${APPNAME}".pot
perl ${CUR_DIR}"/l10n.pl" "${APPNAME}" write


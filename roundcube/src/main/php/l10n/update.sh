#! /bin/bash

if test $# -ne 1; then
	echo "Usage: $0 APPNAME"
	exit 1;
fi

APPNAME="$1"

perl ./l10n.pl "${APPNAME}" read
msgmerge -vU --previous --backup=numbered de/"${APPNAME}".po  templates/"${APPNAME}".pot
perl ./l10n.pl "${APPNAME}" write


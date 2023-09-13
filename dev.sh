#! /usr/bin/env bash
set -euxo nounset
((   $UID ))
if (( $# )) ; then
     M="$*"
else M=update
fi
git pull
git add .
git commit -m update || :
git push             || :

python3 -m build
python3 -m pip install --force-reinstall dist/import_db-*.*.*-py3-none-any.whl
#pytest
python3 -m import_db


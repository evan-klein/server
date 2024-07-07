#!/bin/sh

# Check for required arguments
if [ -z "$1" ] || [ -z "$2" ]; then
	echo '⚠️ Fatal error: required arguments missing\n'
	echo 'Usage:'
	echo '\tsh clone-repo.sh <github_username> <github_repo_name>'
	echo '\tsh clone-repo.sh evan-klein server'
	exit 1
fi

github_username="$1"
github_repo_name="$2"

tmp_dir=`mktemp -d`
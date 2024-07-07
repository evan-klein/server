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

update_symlink=false
if [ -n "$3" ]; then
	if [ "$3" = "1" ] || [ "$3" = "true" ]; then
		update_symlink=true
	fi
fi

tmp_dir=`mktemp -d`

# Clone repo to temporary directory
if git clone --quiet git@github.com:$github_username/$github_repo_name.git $tmp_dir > /dev/null 2>&1; then
	echo '✅ Successfully cloned repo via SSH\n'
else
	if git clone --quiet https://github.com/$github_username/$github_repo_name.git $tmp_dir > /dev/null 2>&1; then
		echo '✅ Successfully cloned repo via HTTPS\n'
	else
		echo '⚠️ Fatal error: failed to clone repo via SSH/HTTPS\n'
		exit 1
	fi
fi

# Get the last commit ID
last_commit_id=`git -C $tmp_dir rev-parse HEAD`

# Get current datetime
timestamp=`date +%Y-%m-%d-%H-%M-%S`

# Paths
path_src_parent="/usr/local/lib/.$github_username/$github_repo_name"
path_src="$path_src_parent/$timestamp--$last_commit_id"
path_symlink_parent="/usr/local/lib/$github_username"
path_symlink="$path_symlink_parent/$github_repo_name"

# Create directories
mkdir -p $path_src_parent
mkdir -p $path_symlink_parent

# Move repo
mv $tmp_dir $path_src

# Create/update symlink?
if $update_symlink ; then
	ln -sfT $path_src $path_symlink
	echo "✅ Symlink created/updated"
else
	echo "⚠️ Symlink not created/updated:\n\tln -sfT $path_src $path_symlink"
fi

# Delete old versions
dirs=`find "$path_src_parent" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' | sort -n`
dirs_count=`echo "$dirs" | wc -l`
if [ "$dirs_count" -gt 5 ]; then
	echo "$dirs" | head -n $((dirs_count - 5)) | cut -d' ' -f2- | while read -r dir; do
		rm -rf $dir
		echo '❌ Deleted old version: $dir'
	done
fi
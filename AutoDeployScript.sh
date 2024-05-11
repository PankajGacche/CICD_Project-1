#!/bin/bash

date=$(date '+%Y-%m-%d %H:%M:%S')

rootfolder="$HOME/CI_CD_project"
projectfolder="$HOME/CI_CD_project/project"

if [ ! -d "$projectfolder" ]; then
    mkdir -p "$projectfolder"
fi

echo "$date - Deploying the latest release" >> "$rootfolder/deployment.log"

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed. Installing jq to run this script' >&2
  sudo apt-get install jq -y
fi

commit_url=$(jq -r '.git_url' "$projectfolder/config.json")
commit_branch=$(jq -r '.git_branch' "$projectfolder/config.json")

git clone "$commit_url" "$rootfolder/project/latest_version"
cd "$rootfolder/project/latest_version"
git checkout "$commit_branch"

cp "$rootfolder/project/latest_version/index.html" /var/www/html/

systemctl restart nginx 

mv "$rootfolder/project/latest_version" "$rootfolder/version_$version"


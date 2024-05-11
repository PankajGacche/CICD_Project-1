#!/bin/bash

date=$(date '+%Y-%m-%d %H:%M:%S')

rootfolder="/home/ubuntu/CICD_Project-1"
projectfolder="/home/ubuntu/CICD_Project-1/project/latest_version"

if [ ! -d "$projectfolder" ]; then
    mkdir -p "$projectfolder"
fi

echo "$date - Deploying the latest release" >> "$rootfolder/deployment.log"

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed. Installing jq to run this script' >&2
  sudo apt-get install jq -y
fi

commit_url=$(jq -r '.git_url' "$rootfolder/config.json")
commit_branch=$(jq -r '.git_branch' "$rootfolder/config.json")

git clone "$commit_url" "$projectfolder"
cd "$projectfolder"
git checkout "$commit_branch"

cp "$projectfolder/index.html" /var/www/html/

systemctl restart nginx

mv "$projectfolder" "$rootfolder/version_$version"


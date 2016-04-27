$NAME = "$env:PROJECT_NAME-v$env:PROJECT_VERSION-windows-$env:PLATFORM"

cargo build --release

# Tag this commit if not already tagged.
git config --global user.email adam.ciganek@gmail.com
git config --global user.name madadam

git config --global credential.helper store
Add-Content "$env:USERPROFILE\.git-credentials" "https://$($env:access_token):x-oauth-basic@github.com`n"

git fetch --tags

if (git tag -l "$env:PROJECT_VERSION") {
  git tag $env:PROJECT_VERSION -am "Version $env:PROJECT_VERSION" $APPVEYOR_REPO_COMMIT
  git push "https://github.com/${APPVEYOR_REPO_NAME}" tag $env:PROJECT_VERSION
}

# Create the release archive
New-Item -ItemType directory -Path staging
New-Item -ItemType directory -Path staging\$NAME
Copy-Item target\release\$env:PROJECT_NAME.exe staging\$NAME
Copy-Item installer\bundle\* staging\$NAME

cd staging
7z a ../$NAME.zip *
Push-AppveyorArtifact ../$NAME.zip

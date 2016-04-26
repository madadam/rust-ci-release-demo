$NAME = "$env:PROJECT_NAME-v$env:VERSION-$env:PLATFORM"

cargo build --release

# Tag this commit if not already tagged.
git config --global user.email adam.ciganek@gmail.com
git config --global user.name madadam
git fetch --tags

if (git tag -l "$env:VERSION") {
  echo "TODO: create and push tag $env:VERSION"
  # git tag $env:VERSION -am "Version $env:VERSION" $APPVEYOR_REPO_COMMIT
  # git push https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_NAME} tag $env:VERSION > /dev/null 2>&1
}

New-Item -ItemType directory -Path staging
New-Item -ItemType directory -Path staging\$NAME
Copy-Item target\release\$env:PROJECT_NAME.exe staging\$NAME
Copy-Item installer\bundle\* staging\$NAME

cd staging
7z a ../$NAME.zip *
cd ..

appveyor PushArtifact $NAME.zip

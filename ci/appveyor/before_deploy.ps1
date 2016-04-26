$NAME = "$PROJECT_NAME-v$VERSION-$PLATFORM"

cargo build --release

# Tag this commit if not already tagged.
git config --global user.email adam.ciganek@gmail.com
git config --global user.name madadam
git fetch --tags

if (git tag -l "$VERSION") {
  echo "TODO: create and push tag $VERSION"
  # git tag $VERSION -am "Version $VERSION" $TRAVIS_COMMIT
  # git push https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG} tag $VERSION > /dev/null 2>&1
}

New-Item -ItemType directory -Path staging
New-Item -ItemType directory -Path staging\$NAME
Copy-Item target\release\$PROJECT_NAME.exe staging\$NAME
Copy-Item installer\bundle\* staging\$NAME

cd staging
7z a ../$NAME.zip *
cd ..

appveyor PushArtifact $NAME.zip

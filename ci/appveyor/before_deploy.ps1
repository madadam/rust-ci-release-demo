$NAME = "$env:PROJECT_NAME-v$env:PROJECT_VERSION-$env:PLATFORM"

echo "Commit message: $env:APPVEYOR_REPO_COMMIT_MESSAGE"
echo "PROJECT_NAME:    $env:PROJECT_NAME"
echo "PROJECT_VERSION: $env:PROJECT_VERSION"
echo "PLATFORM:        $env:PLATFORM"
echo "Name: $NAME"

cargo build --release

# Tag this commit if not already tagged.
git config --global user.email adam.ciganek@gmail.com
git config --global user.name madadam
git fetch --tags

if (git tag -l "$env:PROJECT_VERSION") {
  echo "TODO: create and push tag $env:PROJECT_VERSION"
  # git tag $env:PROJECT_VERSION -am "Version $env:PROJECT_VERSION" $APPVEYOR_REPO_COMMIT
  # git push https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_NAME} tag $env:PROJECT_VERSION > /dev/null 2>&1
}

New-Item -ItemType directory -Path staging
New-Item -ItemType directory -Path staging\$NAME
Copy-Item target\release\$env:PROJECT_NAME.exe staging\$NAME
Copy-Item installer\bundle\* staging\$NAME

cd staging
7z a ../$NAME.zip *
Push-AppveyorArtifact ../$NAME.zip

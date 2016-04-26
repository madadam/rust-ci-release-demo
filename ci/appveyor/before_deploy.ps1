$NAME = "$PROJECT_NAME-v$VERSION-$PLATFORM"

cargo build --release

New-Item -ItemType directory -Path staging
New-Item -ItemType directory -Path staging\$NAME
Copy-Item target\release\$PROJECT_NAME.exe staging\$NAME
Copy-Item installer\bundle\* staging\$NAME

cd staging
7z a ../$NAME.zip *
cd ..

appveyor PushArtifact $NAME.zip

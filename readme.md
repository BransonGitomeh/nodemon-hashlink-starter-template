# haxe setup with hashlink, complete with live restart on code and asset changes

# external dependencies
- node v14
- haxe v4
- yarn v1

### start (run ./dev.sh)
# install all js dependencies
$ yarn
# install all haxe dependencies
$ haxelib install all
# start a watcher that rebuilds your code and starts hashlink
$ yarn dev (starts nodemon to build and run hashlink on changes)

### Releases
- yarn release-hashlink
- yarn release-android
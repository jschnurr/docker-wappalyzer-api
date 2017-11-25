docker-wappalyzer-api
=====

This repository contains a dockerized and 'API-fied' version of [Wappalyzer](https://github.com/AliasIO/Wappalyzer). It aims to make it available through an API endpoint you can call from anywhere. It uses Chrome Headless as execution engine and is built in Go.

Forked from [hunter-io/docker-wappalyzer-api](https://github.com/hunter-io/docker-wappalyzer-api) to remove local
build step (which depends on Go) and fully dockerize.

## To build it:
Clone the repo:
```
git clone git@github.com:jschnurr/docker-wappalyzer-api.git
```

Build a local docker image:
```bash
cd docker-wappalyzer-api
docker build -t wappalyzer-api .
```

## To run it:
```
docker run --name wappalyzer-api --rm -p 3001:3001 wappalyzer-api
```

## To use it:

```
curl -XPOST 'localhost:3001/extract' -d 'url=https://google.com'
```

## License:

Derived work of [Wappalyzer](https://github.com/AliasIO/Wappalyzer/tree/master/src/drivers/npm) and [Automatic Google Chrome Debugger](https://github.com/wirepair/autogcd).

Licensed under [GPL-3.0](https://opensource.org/licenses/GPL-3.0).

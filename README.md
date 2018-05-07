# FossilRepo Docker Image

This image leverages Fossil, which lives here: http://fossil-scm.org/

## What is fossil?

Fossil is a simple, high-reliability, distributed software configuration management system with many advanced features.

## What is special about this image?

1. I grew tired of wishing for newer versions of Fossil, and tweaking the Dockerfile of other projects to get what I wanted. When built via *this* Dockerfile, Fossil is recompiled from the latest code in trunk. This means that obtaining the latest stable version of Fossil is as simple as rebuilding the Docker image. 

1. This image is configured to serve not just a single Fossil repository, but a whole directory full of repositories.

1. Also, the Docker image is quite small - as Fossil is comprised of a single executable and its image is built atop the already tiny Alpine Linux.

## Usage

```
$ docker run -p 8181:8181 dhylton/fossilrepo

```
You can now access your instance via http://localhost:8181 in your browser.

You can also point Fossil to your own pre-existing folder of repositories:

```
$ docker run -p 8181:8181 -v /data/fossils:/fossils -d --name myfosrepos dhylton/fossilrepo
```

You can also run arbitrary fossil commands:

```
$ docker run --it --rm dhylton/fossilrepo version
$ docker run --it --rm -v ~/fossils:/fossils dhylton/fossilrepo info -R /fossils/somerepo.fossil
```


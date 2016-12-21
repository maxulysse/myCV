# myCV

[![myCV version][version-badge]][version-link] [![MIT License][license-badge]][license-link] [![Nextflow version][nextflow-badge]][nextflow-link] [![works on my machine][works-badge]][works-link] [![CircleCI status][circleci-badge]][circleci-link] [![Travis status][travis-badge]][travis-link] [![Docker status][docker-badge]][docker-link]

myCV compiler in Nextflow using XeLaTex.
A Docker container is provided.
It's an Ubuntu 16.04 image containing texlive-xetex and Academicons.

## Usage with Docker:
```bash
nextflow run MaxUlysse/myCV /
-profile docker -with-docker
```

[version-badge]:    https://img.shields.io/badge/myCV-v0.16.1221-green.svg
[version-link]:     https://github.com/MaxUlysse/myCV
[license-badge]:    https://img.shields.io/badge/license-MIT-blue.svg
[license-link]:     https://github.com/MaxUlysse/myCV/blob/master/LICENSE
[works-badge]:      https://img.shields.io/badge/works-on_my_machine-blue.svg
[works-link]:       https://github.com/nikku/works-on-my-machine
[nextflow-badge]:   https://img.shields.io/badge/nextflow-%E2%89%A50.22.2-brightgreen.svg
[nextflow-link]:    https://www.nextflow.io/
[circleci-badge]:   https://circleci.com/gh/MaxUlysse/myCV.svg?style=shield
[circleci-link]:    https://circleci.com/gh/MaxUlysse/myCV
[travis-badge]:     https://img.shields.io/travis/MaxUlysse/myCV.svg
[travis-link]:      https://travis-ci.org/MaxUlysse/myCV
[docker-badge]:     https://img.shields.io/docker/automated/maxulysse/mycv.svg
[docker-link]:      https://hub.docker.com/r/maxulysse/mycv

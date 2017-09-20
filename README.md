# myCV

[![myCV version][version-badge]][version-link] [![MIT License][license-badge]][license-link] [![Nextflow version][nextflow-badge]][nextflow-link] [![works on my machine][works-badge]][works-link] [![CircleCI status][circleci-badge]][circleci-link] [![Travis status][travis-badge]][travis-link] [![Docker status][docker-badge]][docker-link]

myCV compiler in Nextflow using XeLaTex.
A Docker container is provided.
It's an Debian 8.6 image containing texlive-xetex.

## Usage with Docker:
```bash
nextflow run MaxUlysse/myCV -profile docker
```

## Usage with Singularity:
```bash
nextflow run MaxUlysse/myCV -profile singularity
```

[circleci-badge]: https://circleci.com/gh/MaxUlysse/myCV.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/myCV
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/mycv.svg
[docker-link]: https://hub.docker.com/r/maxulysse/mycv
[licence-badge]: https://img.shields.io/github/license/MaxUlysse/myCV.svg
[license-link]: https://github.com/MaxUlysse/myCV/blob/master/LICENSE
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.25.0-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[travis-badge]: https://img.shields.io/travis/MaxUlysse/myCV.svg
[travis-link]: https://travis-ci.org/MaxUlysse/myCV
[version-badge]: https://img.shields.io/badge/myCV-0.17.0920-green.svg
[version-link]: https://github.com/MaxUlysse/myCV
[works-badge]: https://img.shields.io/badge/works-on_my_machine-blue.svg
[works-link]: https://github.com/nikku/works-on-my-machine

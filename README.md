# myCV

[![Version][version-badge]][version-link]
[![License][license-badge]][license-link]
[![Nextflow version][nextflow-badge]][nextflow-link]
[![Travis status][travis-badge]][travis-link]
[![CircleCI status][circleci-badge]][circleci-link]
[![works on my machine][works-badge]][works-link]

myCV compiler in [Nextflow][nextflow-link] using [XeLaTex][xetex-link] and [modernCV][moderncv-link]

## Docker container [![Docker status][docker-badge]][docker-link]
Based on `debian:stretch-slim`.
Contain: `texlive-xetex`, `modernCV` and `academicons`

## Usage with Docker
```bash
nextflow run MaxUlysse/myCV -profile docker
```

[circleci-badge]: https://circleci.com/gh/MaxUlysse/myCV.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/myCV
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/mycv.svg
[docker-link]: https://hub.docker.com/r/maxulysse/mycv
[licence-badge]: https://img.shields.io/github/license/MaxUlysse/myCV.svg
[license-link]: https://github.com/MaxUlysse/myCV/blob/master/LICENSE
[moderncv-link]: https://launchpad.net/moderncv
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.25.0-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[travis-badge]: https://img.shields.io/travis/MaxUlysse/myCV.svg
[travis-link]: https://travis-ci.org/MaxUlysse/myCV
[version-badge]: https://img.shields.io/badge/myCV-0.17.1013-green.svg
[version-link]: https://github.com/MaxUlysse/myCV
[works-badge]: https://img.shields.io/badge/works-on_my_machine-brightgreen.svg
[works-link]: https://github.com/nikku/works-on-my-machine
[xetex-link]: http://xetex.sourceforge.net/

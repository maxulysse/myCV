#!/bin/bash
set -xeuo pipefail

nextflow run . -profile docker

#!/bin/bash
set -xeuo pipefail

for i in `ls -1 *.tex` ; do
  nextflow run . --tex $i
done

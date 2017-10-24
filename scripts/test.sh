#!/bin/bash
set -xeuo pipefail

for i in `ls -1 *.tex` ; do
  nextflow run MaxUlysse/compile-latex --tex $i
done

#!/bin/bash
set -xeuo pipefail

for i in `ls -1 20*/*.tex` ; do
  nextflow run MaxUlysse/compile-latex --tex $i --name CV-MGarcia-latest.pdf --outDir $PWD
done

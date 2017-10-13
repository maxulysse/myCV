#!/bin/bash
set -xeuo pipefail

PROFILE=docker

while [[ $# -gt 0 ]]
do
  key=$1
  case $key in
    -p|--profile)
    PROFILE=$2
    shift # past argument
    shift # past value
    ;;
    *) # unknown option
    shift # past argument
    ;;
  esac
done

for i in `ls -1 *.tex` ; do
  nextflow run . -profile ${PROFILE} --tex $i
done

#!/bin/bash
set -xeuo pipefail

curl -fsSL get.nextflow.io | bash
chmod +x nextflow
sudo mv nextflow /usr/local/bin/

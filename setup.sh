#!/bin/bash
# Sets up bash envirionment to run CMATRIX utility.
# Creates CMATRIX_ROOT which points to the root directory containing
# the CMATRIX tool and adds $CMATRIX_ROOT/bin to the search path.
export CMATRIX_ROOT="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"
export PATH=$CMATRIX_ROOT/bin:$PATH



#!/bin/bash
# The run.sh is a script that will be invoked by the "cmatrix run" command
# to actually execute a case. Is it also the script that is submitted to the
# cluster when the "cmatrix submit" command is excuted.

module add my_tool
my_tool < example.inp


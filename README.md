# cmatrix

## Overview

cmatrix is a command line utility for constructing, executing and managing a
large case matrix of numerical calculations (6DOF sims, CFD runs, etc.). The 
basic idea is that the user defines **templates** which are then specialized 
using parameters specified in a case_matrix parameter file, which is typically
just a CSV file named "case_matrix.csv".

Templates are a collection of files in a directory. They could be anything, but
typically they represent input files for a numerical simulation. Within these 
input files, **replacement tokens** are used to indicate fields that must be set
using data from the case matrix. Replacement tokens consist of the name of a 
column "case_matrix.csv" surrounded by double angle brackets, e.g. `<<case_name>>`, 
`<<mach>>`, `<<alpha>>`.

## Requirements
* Python 2.7

## Install
* Set $CMATRIX_ROOT=\<path_to_repo\>
* Add $CMATRIX_ROOT/bin to your search path

If you use bash, use the provided setup file (and add to .bashrc):

    source <path_to_repo>/setup.sh

## Useage

    cmatrix init folder         # Initializes directory structure in "folder"
    cd folder                   # Must be in project root for all other cmds
    cmatrix create              # Create new working folder for all cases in matrix
    cmatrix create conditional  # Instantiates only cases that meet conditional
    cmatrix submit conditional  # Submits run.sh for execution via qsub
    cmatrix update conditional  # In-place update of files; ignores any outputs

## Conditionals
In a large case matrix, we often only want to work with a subset of the case 
matrix at any given time, e.g. only the Mach = 10.0 cases. Conditionals allow
quick and easy filtering of the case matrix at the commandline. Conditionals 
are any valid Python expression that evaluates to true or false. Conditionals 
may reference case matrix parameters by column name (for this reason, column
names in case_matrix.csv should always be valid Python variable names). Use 
of Python built-in functions and operators is supported.

For example, consider a case_matrix.csv file with columns that include 
"case_name", "mach", and "alpha". The following are examples of valid 
conditionals:

    "mach  == 14.0"
    "alpha <= 10.0"
    "mach  == 14.0 and alpha <= 10.0"
    "case_name.startswith('foo')"
    "'bar' in case_name"
    "'baz' not in case_name"
    etc.
    


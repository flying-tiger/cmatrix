# cmatrix

## Overview

cmatrix is a command line utility for constructing, executing and managing a
large case matrix of numerical calculations (6DOF sims, CFD runs, etc.). The
basic idea is that the user defines **templates** which are then specialized
using parameters specified in a case matrix parameter file, which is typically
just a CSV file named "case_matrix.csv".

Templates are a collection of files in a directory. They could be anything, but
typically they represent input files for a numerical simulation. Within these
input files, **replacement tokens** are used to indicate fields that must be set
using data from the case matrix. Replacement tokens consist of the name of a
column "case_matrix.csv" surrounded by double angle brackets, e.g. `<<case_name>>`,
`<<mach>>`, `<<alpha>>`.

## Requirements
* Python 3.3+

## Install
* Set $CMATRIX_ROOT=\<path_to_repo\>
* Add $CMATRIX_ROOT/bin to your search path

If you use [envrionment modules](http://modules.sourceforge.net/) (and you really
should), a modulefile is provided. I recommend setting a symlink in your
`~/privatemodules` directory pointing to the provided file and telling the module
command to look for private modules:

    # Do this once
    mkdir -p ~/privatemodules
    ln -s <path_to_repo>/modulefile ~/privatemodules/cmatrix

    # Put this in your .bashrc or similar
    module load use.own
    module load cmatrix

## Useage

    cmatrix init folder        # Initializes directory structure in "folder"
    cd folder                  # Must be in project tree for all other cmds
    cmatrix create             # Create new working folder for all cases in matrix
    cmatrix create <selector>  # Instantiates only cases that match selector
    cmatrix update <selector>  # In-place update of case files; leaves output as-is
    cmatrix submit <selector>  # Submits run.sh for execution via qsub
    cmatrix submit ... -- qargs...  # Specify any qsub option (-l, -q) after --

## Selectors
In a large case matrix, we often only want to work with a subset of the case
matrix at any given time, e.g. only the Mach = 10.0 cases. Selectors allow
quick and easy filtering of the case matrix at the commandline. Selectors may be:
 1. A Unix-style wildcard pattern that is matched against case names
 2. A Python expression involving case parameters that evaluates to True/False


Case name matching using wild card patterns is case-sensitive and based on the
Pythons [fnmatch](https://docs.python.org/2/library/fnmatch.html) module. Examples
of valid patterns are:

    "sim*"      # "*" matches any substring
    "sim?"      # "?" matches any single character
    "sim[1-9]"  # "[...]" accepts any character in the set
    "sim[!abc]" # "[!...]" accepts any character not in the set


Conditional expressions maybe any valid Python code that evaluates to True or
False. The expression may reference case matrix parameters by column name (for
this reason, column names in case_matrix.csv should always be valid Python
variable names). Use of Python built-in functions and operators is supported.
Consider a "case_matrix.csv" file with columns that include "name", "mach",
and "alpha". The following are examples of valid conditionals:

    "mach  == 14.0"
    "alpha <= 10.0"
    "mach  == 14.0 and alpha <= 10.0"
    "name.startswith('foo')"
    "'bar' in name"
    "'baz' not in name"


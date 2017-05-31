# Case Matrix How-To

This directory was created using the 'cmatrix init' command. Here's how to use it: 

The case matrix manager creates a new case by copying performing textual replacement
on a *case template*. A case template is a collection of files in a subdirectory of 
of the "templates" folder, and can be pretty much anything. The only requirements is 
that a template contain two files: replace.txt and run.sh.

* replace.txt: Tells case manager which files to perform textual substitution on
* run.sh: Tells case manager how to execute a case

During the textual substitution phase, files are scanned for replacement tokens like
<<mach>> or <<alpha>>; the double angle brackets are what signify a token. When a 
token is found, the case matrix replaces that token with the value in that column of 
the case_matrix.csv parameter file.

Note that templates are *copied* into the working folder prior to textual 
substitution. If you have any big files (e.g. a CFD grid) that should be shared 
among cases, put these files in the "common" folder and use a relative symlink 
in the template folder: 

    common
      |- my_grid_file1.pgrx
      |- my_grid_file2.pgrx
    template
      |- template1
      |    |- grid.pgrx -> ../../common/my_grid_file1.pgrx
      |    |- files.txt
      |    |- run.sh
      |- template2
           |- grid.pgrx -> ../../common/my_grid_file1.pgrx
           |- files.txt
           |- run.sh

Finally, when a case is created, it is placed in the "working" folder. Once you've 
run your analysis and the case is done, move it to the archive. If a case has been
archived, the case manager will skip it when creating/running/submitting cases. 
Furthermore, the case manager will never touch anything in this folder, so there's 
no way to accidentally clobber you cases with a bad 'cmatrix command'.

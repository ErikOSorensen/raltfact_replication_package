# Replication of Henry et al (2022a), "Checking and Sharing Alt-Facts"
- Monica Beeder
- Erik Ø. Sørensen

Replication exercise, of Henry et al (2022a). This
replication was undertaken as part of the "Oslo Replication Games".

## LICENSING

The original replication package `README.pdf` notes that "All data are publicly available", but
not specific license is cited. No license or use restrictions are discussed with respect to the
code. We have decided not to redistribute any of the original code or data, but instead base 
all our code on each replicator downloading the relevant zip-file with data and code from the AEA
repository (Henry et al, 2022b). 

Our code is formulated as patches to the original author's code. The patches are created and applied
using GNU diff/patch tools. 

The patches we distribute are licensed with a BSD 3-Clause License (enclosed as part of Beeder and Sørensen's replication package). 

## Replication computer environment and running time

The replication results were calculated using the following computer and software:

- Intel Xeon E-2136 processor (6 cores), 40GB RAM.
- Ubuntu 20.04.5 LTS. GNU bash 5.0.17, GNU diffutils 3.7 and GNU patch 2.7.6.
  Other versions of the GNU utils should not create issues, they are used in quite trivial ways.
- Stata SE version 16.1. With extra packages installed by the scripts. "SE" is
  necessary since we create a large number of variables to implement the
  expanded (quadratic form) lasso. Stata 16.1
  is the same version used by the original authors (although they used the MP version
  which we do not have access to). We have found that Stata 17 cause minor differences in results because of how the default lasso tunings change which variables are included (and then which observations have this non-missing).
- R 4.2.2, with gt 0.8.0, dplyr 1.0.10, janitor 2.1.0, here 1.0.1, and readr 2.1.3 packages.
  R is only used for compiling and formatting results, the versions should not
  be important.

The main script starts parallel processes for the variant estimations (and can
effectively use 4 cores). The main script finishes in 2-3 minutes of wall
time.



## Running the replication exercise

1. In order to run our replication exercise, first download the replication package zip-file
listed in the references and save it in the `1401611-V1` directory.

2. In order to run with Stata 16, as the original authors, modify (if necessary) the definition
of `STATA16` near the top of `setup.sh`. There is also a STATA17 reference for the purpose
of one of the replication alternatives.

```sh
STATA16=/usr/local/stata16/stata-se
STATA17=/usr/local/stata17/stata-se
```
3. Run the bash script `setup.sh` which will copy over program code unpacked from the zip-file into subdirectories of  `variants`. There are subdirectories named for the replication exercise they correspond to:
     - O: Original specification, should be as in the published paper
     - V: Version of software changed. As O, but estimated with Stata SE-17.0.
     - S: Change in sample, restriction to avoid speeders is removed.
     - L: A more complete lasso-specification, the lasso to predict intent/action to share is done with the same underlying variables and command as for the published paper, but the set of potentially included variables now also includes all quadratic form elements in the same variables. The same quadratic form extension is used for the potentially included variables in the difference regressions (in Panel C of Table 2), using the cross-partialling out method of Chernozhukov et al (2018), with the Stata `xporegress` command with default settings.
     - C: The same potential controls are used for the lasso prediction step and the controls included. This set of variables close to the union of the variables in used in the lasso and control specification of the `O` exercise, but the missing variables in terms of income and voting for Macron is treated the way that maximizes the number of observations (income as in the lasso specification, voting for Macron as in the list of controls).
  
The script will patch the original code with patches that are found in the
`src/` directory, patching the original authors code such that the variants are
estimated and reported in a way that is easy to extract coefficients from.
Finally, the script will run an `R`-script that scans the log-files and output
`.tex` files in the `report/` directory with tabular which can be (minimally)
adjusted for inclusion into the replication report. There is one file output for
Table-2 column 4 replications and one file output form Table-2 column 8
replications.



## The two shell scripts role

There are two distributed shell scripts:

1. `setup.sh` Does all the hard work of unpacking the original replication package, applying patches to specify replication actions, estimates all models, and finally runs the script that summarizes
the variants and puts close-to-publishable `.tex` files in `report/`. 
2.  `makediffs.sh` is run to generate patches. It crates patch files based on how the dofiles in `src/*/` are different from those distributed and unpacked in the replication package distributed by Henry et al (2022b). (Obviously, there was initially a more manual bootstrap action necessary to create the first variants, but going forward the patch-files created by `makediffs.sh` are sufficient). 

## Replication code

### Flow control
The actual replication code is distributed in three flow control files:
```bash
setup.sh
makediffs.sh
formatting_results.R
```
The first two are the shell scripts that are explained above. They run estimation and create patch files. 
The final `formatting_results.R` (run by `setup.sh`) merely reads the output created by the Stata processes started
by `setup.sh` and writes `Column4.tex` and `Column8.tex`, into `report/`, these correspond to the two tables in the
replication report.

### Stata replication code patches
In the `src/` directory, the following patches are used by `setup.sh` to run the replication
estimations:

```sh
tree src
src
├── C
│   ├── 2.analysis_final_paper.do.patch
│   └── Master_replication_HZG.do.patch
├── L
│   ├── 2.analysis_final_paper.do.patch
│   └── Master_replication_HZG.do.patch
├── O
│   ├── 2.analysis_final_paper.do.patch
│   ├── BS_overlap.do
│   └── Master_replication_HZG.do.patch
└── S
    ├── 1.infile_data.do.patch
    ├── 2.analysis_final_paper.do.patch
    └── Master_replication_HZG.do.patch
```

The first subdirectories refer to which replication experiment the files are for. The contents are named
for which of the original files distributed by Henry et al (2002a) are modified. Note that 
the `Master_replication_HZG.do` files are always modified (to set working directory and fix 
installation of Stata packages code). The `2.analysis_final_paper.do` file is changed in all
replication experiments (including the "O" for original) because the output of results is 
modified. For experiments "S" which also change the sample definition (including the 
speeders), the `1.infile_data.do` file also needs to be modified. In the "C" exercise, the
`BS_overlap.do` is run to document the lack of overlap in observations and variables
between the lasso and the control variables. 


## References

- Victor Chernozhukov, Denis Chetverikov, Mert Demirer, Esther Duflo, Christian Hansen, Whitney Newey, James Robins (2018). Double/debiased machine learning for treatment and structural parameters, The Econometrics Journal, 21(1): C1–C68. https://doi.org/10.1111/ectj.12097
- Henry, Emeric and Ekaterina Zhuravskaya and Sergei Guriev (2022a). "Checking and Sharing Alt-Facts." 
American Economic Journal: Economic Policy, 14(3): 55-86. https://doi.org/10.1257/pol.20210037
- Henry, Emeric, Zhuravskaya, Ekaterina, and Guriev, Sergei (2022b). Data and Code for: Checking and Sharing Alt-Facts. Nashville, TN: American Economic Association [publisher], Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributor], 2022-07-26. https://doi.org/10.3886/E140161V1


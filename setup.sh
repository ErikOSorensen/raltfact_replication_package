#!/usr/bin/env bash
echo "Starting at `date`"
STATA16=/usr/local/stata16/stata-se
STATA17=/usr/local/stata17/stata-se
BASE=`pwd`
echo "$BASE"

ORIGINALDIR=$BASE/140161-V1
cd $ORIGINALDIR
unzip -u 140161-V1.zip
cd $BASE
rm -rf $BASE/variants
mkdir $BASE/variants

# First: Unpacking and copying data into place
for v in O S L C V
do 
    mkdir $BASE/variants/$v
    cp $ORIGINALDIR/Master_replication_HZG.do $BASE/variants/$v/
    cp -r $ORIGINALDIR/original_data $BASE/variants/$v/
    cp -r $ORIGINALDIR/dofiles $BASE/variants/$v/
done

# Here comes the variations in do-files for the replication
## First for the original analysis
patch $BASE/variants/O/Master_replication_HZG.do         src/O/Master_replication_HZG.do.patch
patch $BASE/variants/O/dofiles/2.analysis_final_paper.do src/O/2.analysis_final_paper.do.patch
## Then for the original analysis (O) but calculated in Stata v17 (V)
patch $BASE/variants/V/Master_replication_HZG.do         src/O/Master_replication_HZG.do.patch
patch $BASE/variants/V/dofiles/2.analysis_final_paper.do src/O/2.analysis_final_paper.do.patch

## Here for removing the sample restriction to non-speeders
patch $BASE/variants/S/Master_replication_HZG.do         src/S/Master_replication_HZG.do.patch
patch $BASE/variants/S/dofiles/1.infile_data.do          src/S/1.infile_data.do.patch
patch $BASE/variants/S/dofiles/2.analysis_final_paper.do src/S/2.analysis_final_paper.do.patch
## For variant lasso for 
patch $BASE/variants/L/Master_replication_HZG.do          src/L/Master_replication_HZG.do.patch
patch $BASE/variants/L/dofiles/2.analysis_final_paper.do  src/L/2.analysis_final_paper.do.patch
## For a consistent set of control variables between the lasso and the controls in panel C.
patch $BASE/variants/C/Master_replication_HZG.do          src/C/Master_replication_HZG.do.patch
patch $BASE/variants/C/dofiles/2.analysis_final_paper.do  src/C/2.analysis_final_paper.do.patch
## One test for which variables and observations are included/excluded from lasso and control vars
cp src/O/BS_overlap.do $BASE/variants/O/dofiles/


# Running the Analysis in Stata
cd $BASE/variants/O
$STATA16 -b do Master_replication_HZG.do &
cd $BASE/variants/V
$STATA17 -b do Master_replication_HZG.do &
cd $BASE/variants/S
$STATA16 -b do Master_replication_HZG.do &
cd $BASE/variants/L
$STATA16 -b do Master_replication_HZG.do &
cd $BASE/variants/C
$STATA16 -b do Master_replication_HZG.do &
wait

# Summarizing the results and outputting table 2 variants
cd $BASE
Rscript formatting_results.R

echo "Ending at `date`"

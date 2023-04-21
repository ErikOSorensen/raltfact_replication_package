#!/usr/bin/env bash

BASE=`pwd`
ORIGINALDIR=$BASE/140161-V1

O_DIR=$BASE/variants/O
S_DIR=$BASE/variants/S
L_DIR=$BASE/variants/L
C_DIR=$BASE/variants/C

# For running the original analysis of the paper
diff $ORIGINALDIR/Master_replication_HZG.do $O_DIR/Master_replication_HZG.do > $BASE/src/O/Master_replication_HZG.do.patch
diff $ORIGINALDIR/dofiles/2.analysis_final_paper.do $O_DIR/dofiles/2.analysis_final_paper.do > $BASE/src/O/2.analysis_final_paper.do.patch

# For running without the restriction to non-speeders
diff $ORIGINALDIR/Master_replication_HZG.do $S_DIR/Master_replication_HZG.do > $BASE/src/S/Master_replication_HZG.do.patch
diff $ORIGINALDIR/dofiles/1.infile_data.do $S_DIR/dofiles/1.infile_data.do > $BASE/src/S/1.infile_data.do.patch
diff $ORIGINALDIR/dofiles/2.analysis_final_paper.do $S_DIR/dofiles/2.analysis_final_paper.do > $BASE/src/S/2.analysis_final_paper.do.patch

# For running with a more developed lasso
diff $ORIGINALDIR/Master_replication_HZG.do $L_DIR/Master_replication_HZG.do > $BASE/src/L/Master_replication_HZG.do.patch
diff $ORIGINALDIR/dofiles/2.analysis_final_paper.do $L_DIR/dofiles/2.analysis_final_paper.do > $BASE/src/L/2.analysis_final_paper.do.patch

# For running with a more consistent set of controls in lasso and regression controls
diff $ORIGINALDIR/Master_replication_HZG.do $C_DIR/Master_replication_HZG.do > $BASE/src/C/Master_replication_HZG.do.patch
diff $ORIGINALDIR/dofiles/2.analysis_final_paper.do $C_DIR/dofiles/2.analysis_final_paper.do > $BASE/src/C/2.analysis_final_paper.do.patch

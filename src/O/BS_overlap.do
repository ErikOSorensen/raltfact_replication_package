cap log close
log using BS_overlap.txt, text replace
set linesize 80

/*
    This file is intended to investigate the overlap of variables used
    in the (lasso) prediction of willingness to share and the full set of 
    control variables used in the original paper's Table 2 (columns 4 and 8).
*/

/*
    The central part of the lasso regression is this statement:

     lasso linear want_share_alt_facts  $pre_treatment_vars if survey==1&restriction==1 , ///
      selection(adaptive) rseed(1234)

    So first extract what variables are in fact in the $pre_treatment_vars global
*/
cap drop lasso control

display "$pre_treatment_vars"
sum $pre_treatment_vars if survey<4
gen byte lasso  = 1 if survey <4 
foreach i in $pre_treatment_vars {
    di "Testing in lasso variables: `i'"
    replace lasso = lasso * (`i'<.)
}

/*
    In the regressions the command is

    reg diff_act_pred_want_sh_AF i.survey_alt   $strata $strata1 $socio $vote $fb  ///
         $reported  $behavioral i.educ $pre_treatment_vars_all if survey<4, r

*/

display "$strata $strata1 $sosio $vote $fb $reported  $behavioral i.educ $pre_treatment_vars_all"
sum $strata $strata1 $sosio $vote $fb $reported  $behavioral i.educ $pre_treatment_vars_all if survey<4
gen byte control = 1 if survey <4
foreach i in $strata $strata1 $sosio $vote $fb $reported  $behavioral educ $pre_treatment_vars_all {
    di "Testing in control variables: `i'"
    replace control = control * (`i'<.)
}
tab lasso control


log close
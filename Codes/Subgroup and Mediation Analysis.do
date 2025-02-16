clear
import delimited "/ENAR-Group-12/Data/nhanes_comp_CLEAN.csv", colrange(2) stringcols(28)


/******************************* Variable recoding ****************************/
/*bp_control*/
gen bp_control_num = .
replace bp_control_num = 0 if bp_control == "No"
replace bp_control_num = 1 if bp_control == "Yes"
label define bp_control_lbl 0 "Not controlled" 1 "Controlled"
label values bp_control_num bp_control_lbl

/*bp_control*/
gen un_bp_control_num = .
replace un_bp_control_num = 1 if bp_control == "No"
replace un_bp_control_num = 0 if bp_control == "Yes"
label define bp_control_lbl_new 1 "Not controlled" 0 "Controlled"
label values un_bp_control_num bp_control_lbl_new

/*phq9*/

gen phq9_cat_binary_num = .
replace phq9_cat_binary_num = 0 if phq9_cat == "No depression"| phq9_cat =="Minimal depression"
replace phq9_cat_binary_num = 1 if phq9_cat == "Mild depression"|phq9_cat =="Moderately severe depression"|phq9_cat =="Moderate depression"|phq9_cat =="Severe depression"
label define phq9_cat_binary_lbl 0 "No to minimal depression" 1 "Higher than minimal depression"
label values phq9_cat_binary_num phq9_cat_binary_lbl


gen phq9_cat_num = .
replace phq9_cat_num = 0 if phq9_cat == "No depression"
replace phq9_cat_num = 1 if phq9_cat == "Minimal depression"
replace phq9_cat_num = 2 if phq9_cat == "Mild depression"
replace phq9_cat_num = 3 if phq9_cat == "Moderate depression"
replace phq9_cat_num = 4 if phq9_cat == "Moderately severe depression"
replace phq9_cat_num = 5 if phq9_cat == "Severe depression"
label define phq9_cat_lbl 0 "No depression" 1 "Minimal depression" 2 "Mild depression" ///
                         3 "Moderate depression" 4 "Moderately severe depression" 5 "Severe depression"
label values phq9_cat_num phq9_cat_lbl
tab phq9_cat_num, label

/* Severe depression */
gen phq9_severe = .
replace phq9_severe = 0 if phq9_cat == "No depression" | phq9_cat == "Minimal depression" | phq9_cat == "Mild depression" | phq9_cat == "Moderate depression"
replace phq9_severe = 1 if phq9_cat == "Moderately severe depression" | phq9_cat == "Severe depression"
label define phq9_severe_lbl 0 "Not Severe" 1 "Severe"
label values phq9_severe phq9_severe_lbl
tab phq9_severe, label

/* Any depression */
gen phq9_dep = .
replace phq9_dep = 0 if phq9_cat == "No depression"
replace phq9_dep = 1 if phq9_cat == "Mild depression"|phq9_cat =="Moderately severe depression"|phq9_cat =="Moderate depression"|phq9_cat =="Severe depression"| phq9_cat =="Minimal depression"
label define phq9_dep_lbl 0 "No" 1 "Yes"
label values phq9_dep phq9_dep_lbl


/*medication use*/
gen twoplus_med_num = .
replace twoplus_med_num = 0 if medication == "None" | medication == "One" 
replace twoplus_med_num = 1 if medication == "Two" | medication == "Three" | medication == "Four or more"

label define twoplus_med_lbl 0 "No" 1 "Yes"
label values twoplus_med_num twoplus_med_lbl

gen medication_num = .
replace medication_num = 0 if medication == "None"
replace medication_num = 1 if medication == "One"
replace medication_num = 2 if medication == "Two"
replace medication_num = 3 if medication == "Three"
replace medication_num = 4 if medication == "Four or more"

label define medication_lbl 0 "None" 1 "One" 2 "Two" 3 "Three" 4 "Four or more"
label values medication_num medication_lbl


/*gender*/
gen gender_num = .
replace gender_num = 0 if gender == "Women"
replace gender_num = 1 if gender == "Men"

label define gender_lbl 0 "Women" 1 "Men"
label values gender_num gender_lbl

/*race_ethnicity*/
gen race_ethnicity_num = .
replace race_ethnicity_num = 0 if race_ethnicity == "Non-Hispanic White"
replace race_ethnicity_num = 1 if race_ethnicity == "Hispanic"
replace race_ethnicity_num = 2 if race_ethnicity == "Non-Hispanic Black"
replace race_ethnicity_num = 3 if race_ethnicity == "Non-Hispanic Asian"
replace race_ethnicity_num = 4 if race_ethnicity == "Other"

label define race_ethnicity_lbl 0 "Non-Hispanic White" 1 "Hispanic" ///
2 "Non-Hispanic Black" 3 "Non-Hispanic Asian" 4 "Other"
label values race_ethnicity_num race_ethnicity_lbl

/*smoke*/
gen smoke_num = .
replace smoke_num = 0 if smoke == "Never"
replace smoke_num = 1 if smoke == "Former"
replace smoke_num = 2 if smoke == "Current"
label define smoke_lbl 0 "Never" 1 "Former" 2 "Current"
label values smoke_num smoke_lbl

/*diabetes*/

gen diabetes_num = .
replace diabetes_num = 0 if diabetes == "No"
replace diabetes_num = 1 if diabetes == "Yes"
label define diabetes_lbl 0 "No" 1 "Yes"
label values diabetes_num diabetes_lbl


/*cvd*/
gen cvd_num = .
replace cvd_num = 0 if cvd == "No"
replace cvd_num = 1 if cvd == "Yes"
label define cvd_lbl 0 "No" 1 "Yes"
label values cvd_num cvd_lbl


/*age_cat*/
gen age_cat_num = .
replace age_cat_num = 0 if age_cat == "18 to 44"
replace age_cat_num = 1 if age_cat == "45 to 64"
replace age_cat_num = 2 if age_cat == "65 to 74"
replace age_cat_num = 3 if age_cat == "75+"
label define age_cat_lbl 0 "18 to 44" 1 "45 to 64" 2 "65 to 74" 3 "75+"
label values age_cat_num age_cat_lbl

/* Health Insurance */
gen hiq011_num = .
replace hiq011_num = 0 if hiq011 == "No"
replace hiq011_num = 1 if hiq011 == "Yes"
label define hiq011_lbl 0 "No" 1 "Yes", replace
label values hiq011_num hiq011_lbl

/* Health Accessibility */
gen huq030_num = .
replace huq030_num = 0 if huq030 == "No"
replace huq030_num = 1 if huq030 == "Yes"
label define huq030_lbl 0 "No" 1 "Yes", replace
label values huq030_num huq030_lbl

/* Alcohol Use */
gen alq101_num = .
replace alq101_num = 0 if alq101 == "Less than 12 drinks"
replace alq101_num = 1 if alq101 == "At least 12 drinks"
label define alq101_lbl 0 "Less than 12 drinks" 1 "At least 12 drinks", replace
label values alq101_num alq101_lbl

/* Physical Activity */
gen paq650_num = .
replace paq650_num = 0 if paq650 == "Not active"
replace paq650_num = 1 if paq650 == "Active"
label define paq650_lbl 0 "No" 1 "Yes", replace
label values paq650_num paq650_lbl

/* Education */
gen dmdeduc2_num = .
replace dmdeduc2_num = 0 if dmdeduc2 == "Less than 9th grade"
replace dmdeduc2_num = 2 if dmdeduc2 == "High school graduate/GED or equivalent"
replace dmdeduc2_num = 3 if dmdeduc2 == "Some college or AA degree"
replace dmdeduc2_num = 4 if dmdeduc2 == "College graduate or above"
replace dmdeduc2_num = 1 if missing(dmdeduc2_num) & dmdeduc2 != ""

label define dmdeduc2_lbl 0 "Less than 9th grade" 1 "9-11th grade" 2 "High school graduate/GED or equivalent" 3 "Some college or AA degree" 4 "College graduate or above"
label values dmdeduc2_num dmdeduc2_lbl

/* Marital status */ 
gen dmdmartl_num = .
replace dmdmartl_num = 0 if dmdmartl == "Married/Living with partner"
replace dmdmartl_num = 1 if dmdmartl == "Widowed/Divorced/Separated"
replace dmdmartl_num = 2 if missing(dmdmartl_num) & dmdmartl != ""

label define dmdmartl_lbl 0 "Married/Living with partner" 1 "Widowed/Divorced/Separated" 2 "Never married"
label values dmdmartl_num dmdmartl_lbl


/* Labeling Variables */
label variable bp_control "Blood Pressure Control"
label variable phq9_cat_binary_num "PHQ-9 Depression Category (Binary)"
label variable twoplus_med_num "Took Two or More Medications"
label variable medication_num "Medication Use Category"
label variable gender_num "Gender"
label variable race_ethnicity_num "Race/Ethnicity"
label variable smoke_num "Smoking Status"
label variable diabetes_num "Diabetes Diagnosis"
label variable cvd_num "Cardiovascular Disease Diagnosis"
label variable age_cat_num "Age Category"
label variable hiq011_num "Health Insurance Coverage"
label variable huq030_num "Health Care Accessibility"
label variable alq101_num "Alcohol Use"
label variable paq650_num "Physical Activity"
label variable dmdeduc2 "Education Level"
label variable dmdmartl "Marital Status"


gen weight_72yr = .
replace  weight_72yr = svy_weight_mec*2/7.2 if svy_year == "2013-2014"
replace  weight_72yr = svy_weight_mec*2/7.2 if svy_year == "2015-2016"
replace  weight_72yr = svy_weight_mec*3.2/7.2 if svy_year == "2017-2020"

svyset [pweight = weight_72yr], strata(svy_strata) psu(svy_psu)


/**********************************Subgroup models******************************/
/*poisson*/
svy: poisson un_bp_control_num i.twoplus_med_num i.diabetes_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir if phq9_cat_binary_num == 0,irr

svy: poisson un_bp_control_num i.twoplus_med_num i.diabetes_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir if phq9_cat_binary_num == 1,irr	


/********************************* Mediation analysis **************************/
/********************************** medication use ****************************/ 
/** twoplus_med_num ~ categorical depression **/
svy: gsem (twoplus_med_num <- i.phq9_cat_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.twoplus_med_num i.phq9_cat_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

/* Direct effect*/
nlcom exp([un_bp_control_num]_b[3.phq9_cat_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.twoplus_med_num]) * exp([twoplus_med_num]_b[3.phq9_cat_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[3.phq9_cat_num]) + exp([un_bp_control_num]_b[1.twoplus_med_num]) * exp([twoplus_med_num]_b[3.phq9_cat_num]))


/** twoplus_med_num ~ binary depression **/
svy: gsem (twoplus_med_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.twoplus_med_num i.phq9_cat_binary_num i.twoplus_med_num#i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

matrix list e(b) 
/* minimal depression */
/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) * exp([twoplus_med_num]_b[1.phq9_cat_binary_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) * exp([twoplus_med_num]_b[1.phq9_cat_binary_num]))



/**************************** cardiovascular disease***************************/ 
/** cvd ~ binary depression **/
svy: gsem (cvd_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.twoplus_med_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.twoplus_med_num i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

matrix list e(b) 

/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.cvd_num]) * exp([cvd_num]_b[1.phq9_cat_binary_num]) 	

/* Total effect */
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.cvd_num]) * exp([cvd_num]_b[1.phq9_cat_binary_num]))


/******************************** diabetes *************************************/
/** diabetes ~ binary depression **/
svy: gsem (diabetes_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.twoplus_med_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.twoplus_med_num i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)


matrix list e(b) 

/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.diabetes_num]) * exp([diabetes_num]_b[1.phq9_cat_binary_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.diabetes_num]) * exp([diabetes_num]_b[1.phq9_cat_binary_num]))


/************************************ physical activity **********************************/
/** physical activity ~ binary depression **/
svy: gsem (paq650_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.twoplus_med_num i.smoke_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.diabetes_num i.alq101_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.alq101_num i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.twoplus_med_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.paq650_num]) * exp([paq650_num]_b[1.phq9_cat_binary_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.paq650_num]) * exp([paq650_num]_b[1.phq9_cat_binary_num]))


/************************************* smoking ********************************/
/** smoking ~ binary depression **/
svy: gsem (smoke_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.alq101_num i.twoplus_med_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.diabetes_num i.paq650_num dr1tsodi indfmpir,logit) /// 
(un_bp_control_num <- i.twoplus_med_num i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.alq101_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.smoke_num]) * exp([smoke_num]_b[1.phq9_cat_binary_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.smoke_num]) * exp([smoke_num]_b[1.phq9_cat_binary_num]))



/************************************ alcohol**********************************/
/** alcohol ~ binary depression **/
svy: gsem (alq101_num <- i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.twoplus_med_num i.smoke_num i.cvd_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.diabetes_num i.paq650_num dr1tsodi indfmpir, logit) /// 
(un_bp_control_num <- i.alq101_num i.phq9_cat_binary_num i.age_cat_num i.gender_num i.race_ethnicity_num i.twoplus_med_num i.smoke_num i.cvd_num i.diabetes_num i.dmdeduc2_num i.dmdmartl_num i.hiq011_num i.huq030_num i.paq650_num dr1tsodi indfmpir, logit), family(binomial)

/*Direct effect*/
nlcom exp([un_bp_control_num]_b[1.phq9_cat_binary_num])

/* Indirect effect */
nlcom exp([un_bp_control_num]_b[1.alq101_num]) * exp([alq101_num]_b[1.phq9_cat_binary_num]) 	

/*Total effect*/
nlcom (exp([un_bp_control_num]_b[1.phq9_cat_binary_num]) + exp([un_bp_control_num]_b[1.alq101_num]) * exp([alq101_num]_b[1.phq9_cat_binary_num]))

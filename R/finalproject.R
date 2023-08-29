install.packages("medicaldata")
library (medicaldata)
library (tidyverse)
library(gtsummary)

#here package
#my dataset is from a package so I didn't have to set up a working directory
#I just placed a sample here code for exam purpose
# source(here::here("R", "finalproject.R"))
# lico <- read_csv(here::here("data", "raw", "licoricedata.csv"))

#table cleaning
#data (package = "medicaldata")
lic <- medicaldata::licorice_gargle
lico <- lic[, -11:-12:-13:-14:-15:-16:-17:-18:-19]
lico_cols <- c("sex", "asa", "bmi", "age", "mallampati", "smoking", "pain", "treat", "surgerysize",
							 "extubationcough")

#gtsumamry table
tbl_summary(
		lico,
		by = preOp_gender,
		include = c(preOp_gender, preOp_asa,
								 preOp_calcBMI, preOp_age, preOp_mallampati, preOp_smoking, preOp_pain, treat,
								 intraOp_surgerySize, extubation_cough),
		label = list(
			preOp_gender ~ "Gender",
			preOp_asa ~ "ASA physical status",
			preOp_calcBMI ~ "BMI",
			preOp_age ~ "Age",
			preOp_mallampati ~ "Mallampati Score",
			preOp_smoking ~ "Smoking Status",
			preOp_pain ~ "Preoperative Pain",
			treat ~ "Intervention",
			intraOp_surgerySize ~ "Surgery Size",
			extubation_cough ~ "Amount	of	coughing	immediately	after
													extubation"
		),
missing_text = "Missing")

#regression and results
linear_model <- lm(preOp_gender ~ preOp_asa + preOp_calcBMI + preOp_age,
									 data = lico)
tbl_regression(
	linear_model,
	intercept = TRUE,
	label = list(
		preOp_asa ~ "ASA physical status",
		preOp_calcBMI ~ "BMI",
		preOp_age ~ "Age"
		))
# There is no significant difference between gender and ASA, BMI, or Age in the study.

#figure
hist(lico$preOp_calcBMI)

#function
avgvar <- function(x) {
	n <- length(x)
	mean_val <- sum(x) / n
	return(mean_val)
}
avgvar(x = lico$preOp_mallampati)

#create, render quarto doc

#renv
renv::init()
renv::snapshot()

install.packages("medicaldata")
library (medicaldata)
library (tidyverse)
library(gtsummary)

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
			extubation_cough ~ "Amount	of	coughing	immediately	afater
													extubation",
		),
missing_text = "Missing")

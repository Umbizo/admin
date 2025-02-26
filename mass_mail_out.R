#Send a mass mail out to emails from scraping provided in a csv file.
#Define your password as p1 before running example: p1<-"password123"

install.packages("sendmailR")
library(sendmailR)

# Load email list from CSV
email_list <- read.csv("contact_info.csv", stringsAsFactors = FALSE)

# Define sender and SMTP settings
from <- "heatherrobinson@umbizo.co.uk"
smtp <- list(host.name = "smtp.umbizo.co.uk", port = 587, user.name = "heatherrobinson@umbizo.co.uk", passwd = p1, tls = TRUE)

# Email subject and body
subject <- "Health Technologies Investment Opportunity"
body <- "Seeking Partnership for Innovate UK West Yorkshire Health Technologies Grant\n\n
Dear [Investor Partner Name],\n\n
I am writing to express Umbizo's interest in the \"Investor Partnerships – health technologies, West Yorkshire: Round 2\" grant offered by Innovate UK in collaboration with West Yorkshire Combined Authority. As a potential investor partner for this opportunity, I wanted to introduce our company and our innovative healthcare technology solutions that align perfectly with the goals of this Launchpad programme.\n\n
About Umbizo\n
Umbizo is a team of trusted advisors delivering analytical excellence and strategic insights that transform complex challenges into competitive advantages. We combine cutting-edge statistical expertise with deep industry knowledge to drive measurable impact across healthcare, finance, and technology sectors. Our team has extensive experience in clinical trials design, statistical analysis, and healthcare data management, with clients throughout Europe, the USA, and the Middle East.\n\n
Our Innovative Healthcare Technology Solutions\n
We are seeking funding and investment to further develop and commercialise two groundbreaking software solutions:\n\n
1. Treatment Analyzer System\n\n
Our Treatment Analyzer System leverages real-world evidence and artificial intelligence to optimise treatment decision-making for clinicians. The current prototype focuses on oncology, specifically supporting personalised medicine for prostate cancer patients. Key features include:\n\n
- Patient-specific cohort matching for comparative analysis\n
- Benchmarking and visualising key biomarkers against data from matched patients\n
- Interactive visualisation of previously applied treatment pathways and likely outcomes\n
- Machine learning-driven mortality prediction models\n\n
The system has been validated using the MIMIC-IV dataset and is ready for implementation in clinical settings, with potential for significant impact on treatment outcomes and healthcare efficiency.\n\n
2. Clinical Trials Cohort Selector\n\n
Our Clinical Trials Cohort Selector automates the patient selection process using inclusion and exclusion criteria, regularly flagging new eligible patients within Electronic Health Record systems. This solution addresses a critical bottleneck in clinical trials recruitment, featuring:\n\n
- Automated screening that dramatically reduces manual review time\n
- Clinician review interface for test results and inclusion-related patient history\n
- Seamless integration with existing hospital systems\n
- Rapid extraction of cohort patient records for trial management\n\n
Alignment with West Yorkshire Health Technology Cluster\n
We believe these solutions align perfectly with the health technology focus of the West Yorkshire cluster, offering significant potential for:\n\n
- Improving patient outcomes through personalised treatment planning\n
- Accelerating clinical research through efficient trial recruitment\n
- Reducing healthcare costs through optimised treatment selection\n
- Creating high-value jobs in the local health technology ecosystem\n\n
Our Request\n
We would welcome the opportunity to discuss a potential partnership for the Innovate UK Launchpad grant programme. We are seeking approximately £250,000 in grant funding alongside aligned investment to:\n\n
- Complete final development and validation of both software platforms\n
- Implement pilot deployments with regional healthcare providers\n
- Scale our team to support commercialisation and market growth\n\n
I would greatly appreciate the opportunity to share more detailed information about our technologies, business model, and growth plans. I am available for a virtual meeting at your convenience, or in person if you prefer.\n\n
Thank you for considering this partnership opportunity. I look forward to your response."

# Iterate through each recipient and send email
#for (recipient in email_list$Email) {
test_emails<-c("heatherrobinson@umbizo.co.uk")
for (recipient in test_emails) {
  
to <- recipient
  email <- mime_part(body)
  email_msg <- list(from = from, to = to, subject = subject, email)
  
  sendmail(from, to, email_msg, control = smtp)
  
  print(paste("Email sent to:", to))
}

print("All emails have been sent.")

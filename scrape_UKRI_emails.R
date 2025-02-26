# Extract organisation names (all capitalized words at start of first paragraph until first lowercase word, ensuring one result per page)
organisation_pattern <- "(?m)^(?:[A-Z][A-Za-z0-9&@().,]* )+(?=[a-z])"  # Capture capitalized words until first lowercase word
organisations <- unlist(lapply(pdf_text, function(page) {
  match <- str_match(page, organisation_pattern)
  if (!is.na(match[1])) trimws(match[1]) else NA
}))
organisations <- unique(na.omit(organisations))  # Remove NAs and ensure uniqueness per page

# Extract email addresses
email_pattern <- "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"  # Match emails
emails <- unlist(str_extract_all(paste(pdf_text, collapse = " "), email_pattern))

# Ensure only one email per organisation (assuming ordered data)
emails <- emails[1:length(organisations)]

# Create a data frame
contact_info <- data.frame(
  Organisation = organisations,
  Email = emails,
  stringsAsFactors = FALSE
)

# Save to CSV
write.csv(contact_info, "contact_info.csv", row.names = FALSE)

# Print results
print(contact_info)

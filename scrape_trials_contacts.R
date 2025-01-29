import requests
import pandas as pd
from datetime import datetime, timedelta

def fetch_latest_trials(limit=50):
    base_url = "https://clinicaltrials.gov/api/v2/studies"
    one_week_ago = (datetime.utcnow() - timedelta(days=7)).strftime("%Y-%m-%d")
    params = {
        "format": "json",
        "count": limit,
        "fields": ["NCTId", "BriefTitle", "Contacts", "StudyFirstPostDate"],
        "sort": "StudyFirstPostDate:desc"
    }
    
    response = requests.get(base_url, params=params)
    
    if response.status_code != 200:
        print("Failed to retrieve data")
        return []
    
    data = response.json()
    trials = []
    
    for study in data.get("studies", []):
        post_date = study.get("StudyFirstPostDate", "N/A")
        if post_date != "N/A" and post_date >= one_week_ago:
            nct_id = study.get("NCTId", "N/A")
            title = study.get("BriefTitle", "N/A")
            contacts = study.get("Contacts", [])
            
            if contacts:
                for contact in contacts:
                    contact_name = contact.get("Name", "N/A")
                    contact_phone = contact.get("Phone", "N/A")
                    contact_email = contact.get("Email", "N/A")
                    
                    trials.append([nct_id, title, contact_name, contact_phone, contact_email])
            else:
                trials.append([nct_id, title, "No Contact Info", "N/A", "N/A"])
    
    return trials

def save_to_csv(trials, filename="clinical_trials.csv"):
    df = pd.DataFrame(trials, columns=["NCT ID", "Title", "Contact Name", "Phone", "Email"])
    df.to_csv(filename, index=False)
    print(f"Saved {len(trials)} trials to {filename}")

if __name__ == "__main__":
    latest_trials = fetch_latest_trials(10)
    save_to_csv(latest_trials)

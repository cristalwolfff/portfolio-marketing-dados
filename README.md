# 🛡️ CRM Data Hygiene & Segmentation Pipeline
*(Simulating a Salesforce Marketing Cloud Data Workflow)*

![Python](https://img.shields.io/badge/ETL-Python_&_Pandas-3776AB?style=for-the-badge&logo=pandas&logoColor=white)
![SQL](https://img.shields.io/badge/Query-SQL_Segmentation-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Focus](https://img.shields.io/badge/Focus-Data_Quality_&_CRM-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)

> **"Garbage In, Garbage Out."**
> A robust ETL (Extract, Transform, Load) simulation designed to sanitize raw customer data before ingestion into Marketing Automation platforms (like SFMC or HubSpot).

---

## 🎯 The Business Problem
In real-world MarTech operations, data entry errors (typos, duplicates, invalid formats) ruin campaign performance. Sending emails to `gmal.com` or duplicating users damages domain reputation and inflates costs.

**The Goal:** Build an automated pipeline that ingests "dirty" raw data, sanitizes it using Python, and structures it for high-value SQL segmentation.

---

## 🏗️ Architecture: The ETL Process

### 1. Extract & Transform (Python/Pandas)
The script `etl_pipeline.py` acts as the gatekeeper. It processes the raw CSV and applies strict validation rules:

* **De-duplication:** Identifies and merges duplicate records based on unique identifiers (Email).
* **String Normalization:** Standardizes naming conventions (Title Case) and email formats (lowercase) to ensure matching accuracy.
* **Regex Validation:** Fixes common domain typos (e.g., auto-correcting `@gmil.com` to `@gmail.com`).
* **Null Handling:** Imputes or flags missing critical data (like Birth Date) to prevent campaign errors.

### 2. Load & Segment (SQL Strategy)
Once the data is cleaned (loaded into `clean_customers.db`), we use SQL to build **Strategic Audiences**. This simulates creating **Data Extensions** in Salesforce Marketing Cloud.

---

## 📊 SQL Segmentation Strategy
*Examples of high-impact queries used in this project:*

### 💎 1. High-LTV Retention (VIPs)
**Goal:** Invite top-tier local customers to an exclusive event.
```sql
SELECT CustomerID, Name, Email
FROM Clean_Customers
WHERE TotalSpend > 1500.00
AND City = 'Uberlandia';

```

### 🚨 2. Churn Prevention (Win-Back)

**Goal:** Trigger a re-engagement flow for users who haven't purchased in 90 days.

```sql
SELECT CustomerID, Email, LastPurchaseDate
FROM Clean_Customers
WHERE LastPurchaseDate < DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY);

```

### 👋 3. Onboarding Cycle (New Users)

**Goal:** Target users for the "Welcome Series" automation (Day 0-30).

```sql
SELECT CustomerID, Name, Email
FROM Clean_Customers
WHERE SignupDate >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);

```

### 🎂 4. Contextual Personalization (Birthdays)

**Goal:** Monthly automated delight campaign.

```sql
SELECT CustomerID, Name, Email
FROM Clean_Customers
WHERE MONTH(BirthDate) = MONTH(CURRENT_DATE);

```

---

## 🚀 How to Run

1. **Clone the repository:**
```bash
git clone [https://github.com/cristalwolfff/crm-data-pipeline.git](https://github.com/cristalwolfff/crm-data-pipeline.git)

```


2. **Install Requirements:**
```bash
pip install pandas

```


3. **Run the ETL Script:**
```bash
python etl_simulation.py

```


*(This will generate the `clean_data.csv` file)*

---

## 🛠️ Tech Stack

* **Python (Pandas):** For data manipulation and cleaning.
* **SQL:** For logic-based audience segmentation.
* **Business Context:** CRM & Marketing Automation best practices.

---

*Developed by [Cristalwolf](https://github.com/cristalwolfff) // MarTech Engineer*

```

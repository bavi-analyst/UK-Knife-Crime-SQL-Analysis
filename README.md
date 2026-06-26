# UK Police Knife Crime SQL Analysis
### Python | SQL | MySQL | 5.8 Million Records | Apr 2025 – Mar 2026

---

## The Problem

Knife crime in England and Wales has been rising consistently.
Every police force records crime data that is published monthly
by the UK government — but nobody had pulled a full year across
all 43 forces into one place and asked focused analytical questions.

This project builds the complete pipeline: download, combine,
load into a database, and query using SQL.

---

## Key Findings

**Most recorded knife crime by force (Possession of Weapons)**
| Force | Crimes Recorded |
|-------|----------------|
| West Midlands Police | 6,768 |
| Metropolitan Police Service | 6,279 |
| West Yorkshire Police | 2,597 |
| Sussex Police | 2,562 |
| Hampshire Constabulary | 2,553 |

West Midlands Police recorded the highest volume of
possession of weapons offences in England and Wales
across the 12-month period April 2025 to March 2026.

**Volume categories across all 43 forces**
Forces were classified using CASE WHEN logic:
- High volume (>5,000 crimes): 2 forces
- Medium volume (1,000–5,000): 14 forces
- Low volume (<1,000): 27 forces

---

## Pipeline I Built

**Step 1 — Data download**
Downloaded 12 months of crime data (April 2025 to March 2026)
for all 43 police forces from data.police.uk — free and publicly
available, no login required.

**Step 2 — Python combine script**
507 separate CSV files (one per force per month) combined into
a single 5,834,819-row dataset using a Python pandas script.

**Step 3 — MySQL database load**
Loaded 5.8 million rows into MySQL using LOAD DATA INFILE,
completing in 117 seconds with zero errors.
Resolved 3 real technical issues during loading:
- GUI import too slow (>1 hour) → switched to bulk load
- MySQL security restriction (secure_file_priv) → moved file
- 30-second connection timeout → increased to 600 seconds

**Step 4 — SQL analysis**
Wrote 5 analytical queries answering real research questions.

---

## SQL Queries Written

| Query | Concepts Used |
|-------|---------------|
| Top forces by knife crime volume | SELECT, WHERE, GROUP BY, COUNT, ORDER BY |
| Crime type discovery | SELECT DISTINCT |
| Volume classification by force | CASE WHEN, GROUP BY |
| Monthly trend analysis | GROUP BY month, ORDER BY ASC |
| Forces above national average | Subquery, AVG, HAVING |

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Python 3 + pandas | Combined 507 CSV files into one dataset |
| MySQL 8.0 | Database for storing and querying 5.8M rows |
| MySQL Workbench | Writing and running SQL queries |

---

## Files in This Repository

| File | Description |
|------|-------------|
| `knife_crime_queries.sql` | All 5 SQL queries used in the analysis |
| `combine.py` | Python script that combined 507 CSV files |
| `results_screenshot.png` | Screenshot of query results in MySQL Workbench |
| `README.md` | This file |

---

## Data Source

data.police.uk — Official UK government open crime data
Free, publicly available, updated monthly.
https://data.police.uk/data/

---

## About This Project

Self-led portfolio project using real government data to
demonstrate a complete data engineering and SQL analysis
pipeline — from raw files through to findings.

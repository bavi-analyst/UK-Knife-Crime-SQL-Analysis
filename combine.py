import os
import glob
import pandas as pd

# Your exact folder path
folder = r"C:\Users\rkbav\Desktop\UK_Crime_SQL_Project\01_Raw_Data"

# Find all street.csv files in all sub-folders
all_files = glob.glob(folder + "/**/*street*.csv", recursive=True)

print(f"Found {len(all_files)} CSV files")

# Combine them all into one dataframe
df = pd.concat([pd.read_csv(f) for f in all_files], ignore_index=True)

print(f"Total rows: {len(df)}")
print(f"Columns: {list(df.columns)}")

# Save combined file
output = folder + r"\crimes_combined.csv"
df.to_csv(output, index=False)
print(f"Saved to: {output}")
print("DONE - file is ready for MySQL Workbench")
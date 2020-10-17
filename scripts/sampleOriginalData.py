import pandas as pd

"""
This is meant to sample data for the demo since there are thousands of entries and the script
to populate the data only inserts at about 100 entires per minute.

Place the csv in the uppermost directory.
"""

df = pd.read_csv('../pollution_us_2000_2016.csv', delimiter=',')
df = df.drop(columns=['Unnamed: 0'])
print(df.info(verbose=True))

# Sample 50 datapoints with a seed of 43
sample = df.sample(n=50, random_state=43)
sample.to_csv('../sampleData.csv', index=False)
print("\nTop 5 Lines in the Sample\n")
print(sample.head())
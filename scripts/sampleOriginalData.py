import pandas as pd

"""
This is meant to sample data for the demo since there are thousands of entries and the script
to populate the data only inserts at about 100 entires per minute.
"""

a = pd.read_csv('pollution_us_2000_2016.csv', delimiter=',')
print('wow')
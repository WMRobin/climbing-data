import pandas as pd

def my_open(file, comp='zip'):
    df = pd.read_pickle(file + '.pkl.zip', compression = comp)
    df.to_csv(file + '.csv')

# my_open('curated_datasets/Sector_Addresses')
# my_open('curated_datasets/RouteQualityData')
# my_open('curated_datasets/All_Ratings')
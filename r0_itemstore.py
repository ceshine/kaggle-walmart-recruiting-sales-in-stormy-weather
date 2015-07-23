import pandas as pd
import numpy as np


def create_vaild_item_store_combinations(_df):
    df = _df.copy()
    df['log1p'] = np.log(df['units'] + 1)

    g = df.groupby(["store_nbr", "item_nbr"])['log1p'].mean()
    g = g[g > 0.0]

    store_nbrs = g.index.get_level_values(0)
    item_nbrs = g.index.get_level_values(1)

    store_item_nbrs = sorted(
        zip(store_nbrs, item_nbrs), key=lambda t: t[1] * 10000 + t[0])

    with open(store_item_nbrs_path, 'wb') as f:
        f.write(bytes("store_nbr,item_nbr\n", 'utf-8'))
        for sno, ino in store_item_nbrs:
            f.write(bytes("{},{}\n".format(sno, ino), 'utf-8'))

store_item_nbrs_path = 'model/store_item_nbrs.csv'
df_train = pd.read_csv("data/train.csv")
create_vaild_item_store_combinations(df_train)

import os
from tqdm import tqdm
import time

os.system('clear')

for i in tqdm (range (100), desc="Testing"):
    time.sleep(2)
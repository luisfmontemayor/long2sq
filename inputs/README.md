# Explanation of inputs
- ***input_1.csv***: made with `python -c 'import string; import random; print(*(f"{string.ascii_lowercase[i]},{string.ascii_lowercase[j]},{random.random()}" for i in range(26) for j in range(i+1, 26)), sep="\n")'`

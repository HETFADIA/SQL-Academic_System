import random
import string
num=8*10**4
sin_comma="'"
comma=","
table_name="production_company"
arr=[]
for i in range(1,num+1):
    name="".join(random.choice(string.ascii_lowercase) for i in range(10))
    address="".join(random.choice(string.ascii_lowercase) for i in range(30))
    values=str(i)+comma+sin_comma+name+sin_comma+comma+sin_comma+address+sin_comma
    arr.append(f"INSERT INTO {table_name} VALUES({values});")
random.shuffle(arr)
print(*arr,sep="\n")

"""
truncate table Actor;
"""

"""
How to run;
python table_production.py > list.sql
"""
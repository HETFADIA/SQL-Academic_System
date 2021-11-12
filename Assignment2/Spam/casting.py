import random
import string
import sys
sys.stdout=open('casting.sql','a')
num=10**6
sin_comma="'"
comma=","
table_name="casting"
arr=[]
for i in range(1,num+1):
    s=set()
    while len(s)<4:
        actor=random.randint(1,300000)
        s.add(actor)
    
    for j in s:
        values=str(i)+comma+str(j)
        arr.append(f"INSERT INTO {table_name} VALUES({values});")
random.shuffle(arr)
print(*arr,sep="\n")

"""
truncate table Actor;
"""

"""
How to run;
python movie.py
"""
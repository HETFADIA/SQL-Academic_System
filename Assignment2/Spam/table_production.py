import random
import string
s=set()
num=3*10**5
sin_comma="'"
arr=[]
for i in range(1,num+1):
    st="".join(random.choice(string.ascii_lowercase) for i in range(15))
    while st in s:
        st="".join(random.choice(string.ascii_lowercase) for i in range(15))
    s.add(st)
    values=str(i)+","+sin_comma+st+sin_comma
    arr.append(f"INSERT INTO Actor VALUES({values});")
random.shuffle(arr)
print(*arr,sep="\n")

"""
truncate table Actor;
"""

"""
How to run;
python table_.py > list.sql
"""
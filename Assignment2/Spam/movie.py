import random
import string
num=10**6
sin_comma="'"
comma=","
table_name="movie"
arr=[]
for i in range(1,num+1):
    name="".join(random.choice(string.ascii_lowercase) for i in range(10))
    year=random.randint(1900,2000)
    imdb=random.uniform(1,5)

    if i<=num*0.9:
        pc_id=random.randint(1,500)
    else:
        pc_id=random.randint(501,8*10**4)
    values=str(i)+comma+sin_comma+name+sin_comma+comma+str(year)+comma+str(imdb)+comma+str(pc_id)
    arr.append(f"INSERT INTO {table_name} VALUES({values});")
random.shuffle(arr)
print(*arr,sep="\n")

"""
truncate table Actor;
"""

"""
How to run;
python movie.py > list.sql
"""
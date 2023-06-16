print ("Hello from pythonfile3.py")

import math

sum=0
cont=0
mes=0

final=3000
listaPRE = [0,0,0,0,0,0,0,0,0,0,0,0]

listaPOS = []

for i in len(listaPRE):
    if listaPRE[i] != 0:
        cont+=1
        sum+=listaPRE[i]

if sum != 0:
    final = final - sum

mes=final/78

for i in len(listaPRE):
    if listaPRE[i] == 0:
        listaPOS[i] = round(mes)
    if listaPRE[i] != 0:
        listaPOS[i] = listaPOS[i]


print(listaPOS)
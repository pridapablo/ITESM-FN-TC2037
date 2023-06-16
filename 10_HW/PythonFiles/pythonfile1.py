print("Hello from pythonfile1.py")

import mysql.connector
import matplotlib.pyplot as plt
import numpy as np
import keyboard

def actualizarGraficos():
    temp = []
    hum = []
    acel = []
    dist = []

    mydb = mysql.connector.connect(
      host="localhost",
      user="Team3",
      password="12345678",
      database="tablateam3"
    )

    mycursor = mydb.cursor()
   
    mycursor.execute("SELECT * FROM tabla_temp")
    tempe = mycursor.fetchall()

    mycursor.execute("SELECT * FROM tabla_hum")
    hume = mycursor.fetchall()

    mycursor.execute("SELECT * FROM tabla_acel")
    acele = mycursor.fetchall()

    mycursor.execute("SELECT * FROM tabla_dist")
    dista = mycursor.fetchall()


    for x in range(0,len(tempe)):
        t=tempe[x]
        temp.append(t[1])
        h=hume[x]
        hum.append(h[1])
        a=acele[x]
        acel.append(a[1])
        d=dista[x]
        dist.append(d[1])

    figure, axis = plt.subplots(2, 2)

    axis[0,0].plot(temp)
    axis[0,0].set_title("Temperatura")

    axis[1,0].plot(hum)
    axis[1,0].set_title("Humedad")

    axis[0,1].plot(acel)
    axis[0,1].set_title("Aceleracion")

    axis[1,1].plot(dist)
    axis[1,1].set_title("Distancia")
   
    plt.show()

actualizarGraficos()

while True:
    print(keyboard.read_key())
    if keyboard.read_key() == "r":
        print("Actualizando datos...")
        actualizarGraficos()
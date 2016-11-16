# *-* coding: utf-8 *-*

import matplotlib.pyplot as plt
import numpy as np

def plotPic(name,temperature):
    y = np.loadtxt(name)
    x = np.arange(len(y))

    (m,b)=np.polyfit(x[5000:],y[5000:],1)
    yp = np.polyval([m,b],x)

    plt.plot(x,y,label='data')
    plt.plot(x,yp,label='sovitus %f' %m)
    plt.title(u'hiukkasen keskimääräinen neliöpoikkeama ajan funktiona kun T=%d' %temperature)
    plt.xlabel('t')
    plt.ylabel('<x^2>')
    plt.legend(loc=4)
    plt.show()

plotPic('../run/T2pitka.txt',2)
plotPic('../run/T5pitka.txt',5)
plotPic('../run/T10pitka.txt',10)
plotPic('../run/T20pitka.txt',20)
plotPic('../run/T55pitka.txt',55)
plotPic('../run/T100pitka.txt',100)
plotPic('../run/T300pitka.txt',300)
plotPic('../run/T650pitka.txt',650)
plotPic('../run/T1000pitka.txt',1000)

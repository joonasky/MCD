import matplotlib.pyplot as plt
import numpy as np

def plotPic(fname,T):
    E = np.loadtxt("../run/E(i).txt")
    P = np.loadtxt(fname)
    index = []
    for i in range(0,len(P)-1):
        if (P[i]/100.0 == 0):
            index.append(i)
    P = np.delete(P,index)
    E = np.delete(E,index)
    P = -np.log(P/100.0)
    E = -E/T
#    P = P[:3000]
#    E = E[:3000]
    
    (m,b)=np.polyfit(E,P,1)
    yp = np.polyval([m,b],E)

    plt.figure(T)
    plt.plot(E,P,label='data')
    plt.plot(E,yp,label='sovitus %f' %m)
    plt.title(u'ln(P(x)) Ei/T:n funktiona kun T=%d' %T)
    plt.xlabel('-Ei/T')
    plt.ylabel('-ln(P(x))')
    plt.legend(loc=4)
    plt.savefig("../pics/probT%d.png" %T)

plotPic('../run/t2prob.txt',2.0)
plotPic('../run/t5prob.txt',5.0)
plotPic('../run/t10prob.txt',10.0)
plotPic('../run/t20prob.txt',20.0)
plotPic('../run/t55prob.txt',55.0)
plotPic('../run/t100prob.txt',100.0)
plotPic('../run/t300prob.txt',300.0)
plotPic('../run/t650prob.txt',650.0)
plotPic('../run/t1000prob.txt',1000.0)

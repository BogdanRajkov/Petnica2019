import numpy as np
import matplotlib.pyplot as plt

k_arr = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
fmin = {}
fmin_linear = {}

for i in k_arr:
	f = open('go 3/podaci/n'+str(i)+'.log')
	lines = f.readlines()
	f.close()
	fmin[i] = float(lines[8][18:-1])
	f = open('go 3 linear/podaci/n'+str(i)+'.log')
	lines = f.readlines()
	f.close()
	fmin_linear[i] = float(lines[8][18:-1])
	
plt.scatter([x for x in fmin], [1-fmin[x] for x in fmin], c='b', label='unconstrained')
plt.scatter([x for x in fmin_linear], [1-fmin_linear[x] for x in fmin_linear], c='r', label='constrained')
plt.suptitle('Zavisnost optimalne efikasnosti od broja slojeva')
plt.xlabel('Broj slojeva')
plt.ylabel('Efikasnost optimalne sfere')
plt.legend()
plt.savefig('fit_plot.jpg')
	
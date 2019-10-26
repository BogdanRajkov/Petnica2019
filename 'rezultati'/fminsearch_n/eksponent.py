import numpy as np
import matplotlib.pyplot as plt

path = 'go 3/'
path_linear = 'go 3 linear/'
k_arr = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
exp = {}
exp_linear = {}

for i in k_arr:
	f = open(path + 'fitovi/n'+str(i)+'.log')
	exp[i] = float(f.readline().split()[-1])
	f.close()
	f = open(path_linear + 'fitovi/n'+str(i)+'.log')
	exp_linear[i] = float(f.readline().split()[-1])
	f.close()
	#print(exp[i])

y = [exp[i] for i in k_arr]
y_linear = [exp_linear[i] for i in k_arr]
plt.scatter(k_arr, y, c='b', label='unconstrained')
plt.scatter(k_arr, y_linear, c='r', label='constrained')

# t = np.linspace(k_arr[0], k_arr[-1])
# A = np.vstack([k_arr, np.ones(len(k_arr))]).T
# [[m, c], res] = np.linalg.lstsq(A, y, rcond=None)[:2]
# plt.plot(t, m*t + c)

plt.suptitle('Zavisnost eksponenta od broja slojeva')
plt.xlabel('Broj slojeva')
plt.ylabel('Fitovani eksponent indeksa prelamanja')
plt.legend()
plt.savefig('eksponent.jpg')

# f = open('eksponent.log', 'w')
# f.write('m = '+str(m)+'\n')
# f.write('c = '+str(c)+'\n')
# f.write('res = '+str(res[0])+'\n')
# f.close()

import numpy as np
import matplotlib.pyplot as plt
import re

for k in [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]:
	f = open('go 3/podaci/n'+str(k)+'.log')
	lines = f.readlines()
	f.close()
	line = lines[7]
	line = line[11:]
	n_arr = re.split(', |,\n', line)
	n_arr = list(filter(None, n_arr))
	n_arr = list(map(float, n_arr))
	x = np.log(5*np.arange(1 - 1/(2*k), 0, -1/k))
	y = np.log(n_arr)
	M = np.zeros(k)
	C = np.zeros(k)
	RES = np.zeros(k)
	
	for i in range(2, k+1):
		A = np.vstack([x[:i], np.ones(i)]).T
		ans = np.linalg.lstsq(A, y[:i], rcond=None)[:2]
		# print(ans)
		[M[i-2], C[i-2]] = ans[0]
		if len(ans[1]) == 0:
			RES[i-2] = 0
		else:
			RES[i-2] = ans[1][0]
	
	f = open('go 3/fitovi/det'+str(k)+'.log', 'w')
	f.write('M =' + str(M) + '\n')
	f.write('C =' + str(C) + '\n')
	f.write('RES =' + str(RES) + '\n')
	f.close()

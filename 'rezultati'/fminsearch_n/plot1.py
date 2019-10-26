import numpy as np
import matplotlib.pyplot as plt
import re

# fit = {3:-1, 4:-1, 5:-1, 7:5, 8:5, 9:6, 10:7, 11:7}
fit = {12:8, 13:9, 14:9, 15:10, 16:9}

for i in [14]:
	f = open('go 3/podaci/n'+str(i)+'.log')
	lines = f.readlines()
	f.close()
	f = open('go 3/fitovi/n'+str(i)+'.log', 'w')
	line = lines[7]
	line = line[11:]
	n_arr = re.split(', |,\n', line)
	n_arr = list(filter(None, n_arr))
	n_arr = list(map(float, n_arr))
	x = np.log(5*np.arange(1 - 1/(2*i), 0, -1/i))	 
	y = np.log(n_arr)

	if fit[i] == -1:
		plt.scatter(x, y)
		plt.suptitle('Logaritam indeksa prelamanja od logaritma udaljenosti')
		plt.xlabel('Logaritam udaljenosti od centra sfere')
		plt.ylabel('Logaritam indeksa prelamanja')
		plt.savefig('go 3/slike/n'+str(i)+'.jpg')
		plt.close()
	else:
		if fit[i] != i:
			t = np.linspace(x[0], x[fit[i]-1])
			A = np.vstack([x[:fit[i]], np.ones(fit[i])]).T
			[[m_t, c_t], res_t] = np.linalg.lstsq(A, y[:fit[i]], rcond=None)[:2]
			plt.plot(t, m_t*t+c_t)
			plt.scatter(x, y)
			plt.suptitle('Logaritam indeksa prelamanja od logaritma udaljenosti')
			plt.xlabel('Logaritam udaljenosti od centra sfere')
			plt.ylabel('Logaritam indeksa prelamanja')
			plt.savefig('go 3/slike/n'+str(i)+'_t.jpg')
			plt.close()
			f.write('m_t = '+str(m_t)+'\n')
			f.write('c_t = '+str(c_t)+'\n')
			f.write('res_t = '+str(res_t[0])+'\n')
		t = np.linspace(x[0], x[-1])
		A = np.vstack([x, np.ones(len(x))]).T
		[[m, c], res] = np.linalg.lstsq(A, y, rcond=None)[:2]
		plt.plot(t, m*t+c)
		plt.scatter(x, y)
		plt.suptitle('Logaritam indeksa prelamanja od logaritma udaljenosti')
		plt.xlabel('Logaritam udaljenosti od centra sfere')
		plt.ylabel('Logaritam indeksa prelamanja')
		plt.savefig('go 3/slike/n'+str(i)+'.jpg')
		plt.close() 
		f.write('m = '+str(m)+'\n')
		f.write('c = '+str(c)+'\n')
		f.write('res = '+str(res[0])+'\n')

	f.close()
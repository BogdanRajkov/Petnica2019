import numpy as np
import matplotlib.pyplot as plt
import re

path = 'go 3 linear/'
fit = {7:5, 8:5, 9:6, 10:7, 11:8, 12:8, 13:9, 14:10, 15:10, 16:11}

for i in fit:
	f = open(path + 'podaci/n'+str(i)+'.log')
	lines = f.readlines()
	f.close()
	f = open(path + 'fitovi/n'+str(i)+'.log', 'w')
	line = lines[7]
	line = line[11:]
	n_arr = re.split(', |,\n', line)
	n_arr = list(filter(None, n_arr))
	n_arr = list(map(float, n_arr))
	x = np.log(5*np.arange(1 - 1/(2*i), 0, -1/i))	 
	y = np.log(n_arr)

	plt.scatter(x, y)
	plt.suptitle('Logaritam indeksa prelamanja od logaritma udaljenosti')
	plt.xlabel('Logaritam udaljenosti od centra sfere')
	plt.ylabel('Logaritam indeksa prelamanja')
	plt.savefig(path + 'slike/n'+str(i)+'.jpg')
	plt.close()
	
	if fit[i] != i:
		t = np.linspace(x[0], x[fit[i]-1])
		A = np.vstack([x[:fit[i]], np.ones(fit[i])]).T
		[[m_t, c_t], res_t] = np.linalg.lstsq(A, y[:fit[i]], rcond=None)[:2]
		plt.plot(t, m_t*t+c_t)
		plt.scatter(x, y)
		plt.suptitle('Logaritam indeksa prelamanja od logaritma udaljenosti\n')
		plt.suptitle(str(i)+' slojeva', fontsize='medium')
		plt.xlabel('Logaritam udaljenosti od centra sfere')
		plt.ylabel('Logaritam indeksa prelamanja')
		plt.savefig(path + 'slike/n'+str(i)+'_t.jpg')
		plt.close()
		f.write('m_t = '+str(m_t)+'\n')
		f.write('c_t = '+str(c_t)+'\n')
		f.write('res_t = '+str(res_t[0])+'\n')

	f.close()

import mypack.plots as mpp
import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import interp1d

plt.switch_backend('pgf')
plt.style.use('thesis')

np.random.seed(42)

T = np.concatenate(
    [np.random.normal(16, 0.3, 250),
     np.random.normal(17, 0.35, 300)]
)

bmin, bmax = 15, 18
bins = np.linspace(bmin, bmax, int((bmax-bmin)*10+1))
h, _ = np.histogram(T, bins=bins, density=True)

avg = np.mean(T)
std = np.std(T)
x = np.linspace(bmin, bmax, 500)
g = 1./(std*np.sqrt(2*np.pi)) * np.exp(-.5*((x-avg)/std)**2)

f_interp = interp1d(bins[:-1], h, kind='nearest',
                    bounds_error=False, fill_value=(h[0], h[-1]))

fig, ax = plt.subplots(figsize=mpp.get_figsize(0.6, columnwidth=398))
fig.subplots_adjust(left=0.2, bottom=0.2, right=0.98, top=0.98)

ax.plot(bins[:-1], h, ds='steps-mid', color='k')
ax.plot(x, g, color='red')
ax.fill_between(x, g, f_interp(x), alpha=0.3, color='red')

ax.set_xlabel(r'Température [\unit{\degreeCelsius}]')
ax.set_ylabel(r'Fréquence [N/A]')

fig.savefig("./resources/méthodes/bimodality.pdf")

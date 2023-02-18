
import mypack.plots as mpp
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.offsetbox import AnchoredText
from scipy.interpolate import interp1d

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

fig, ax = plt.subplots(figsize=mpp.get_figsize(0.6, columnwidth=398),
                       layout='constrained')

ax.plot(bins[:-1], h, ds='steps-mid', color='k')
ax.plot(x, g, color='red')
ax.fill_between(x, g, f_interp(x), alpha=0.3, color='red')

ax.set_xlabel(r'Température [°C]')
ax.set_ylabel(r'Fréquence [N/A]')

an_pos = (x[380], g[380])
an_text = AnchoredText(
    "fit gaussien", loc="upper right",
    pad=0.1, borderpad=0.2
)
an_text.patch.set_edgecolor('none')
ax.add_artist(an_text)
ax.annotate("", an_pos, xycoords="data",
            xytext=(0.5, 0.), textcoords=an_text,
            arrowprops=dict(
                arrowstyle='-', shrinkA=0, color='red', lw=1.2,
                connectionstyle='angle,angleA=-90,angleB=45,rad=2'
            ))

fig.savefig("./resources/méthodes/bimodality.pdf")

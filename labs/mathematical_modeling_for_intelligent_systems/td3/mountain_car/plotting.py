import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib import animation
# import math
import sys


def curve(fx):
    return 0.07*np.cos(2*np.pi/1.7*(fx - 0.5))


def render_mountain_car(x):
    fig = plt.figure()
    plt.grid()
    ax = fig.add_subplot(111)
    ax.set_xlim(-1.5, 0.8)
    ax.set_ylim(-0.1, 0.1)
    plt.text(0.5, 0.8, f"{len(x)} actions",
             horizontalalignment='center', verticalalignment='center', transform=ax.transAxes)

    fx = np.linspace(-1.2, 0.5, 100)
    fy = curve(fx)
    plt.plot(np.linspace(-1.2, 0.5, 100), fy, 'r')
    plt.plot(np.linspace(-1.5, -1.2, 2), np.linspace(-1.5, -1.2, 2)*sys.float_info.epsilon + 0.07, 'r')
    plt.plot(np.linspace(0.5, 0.8, 2), np.linspace(0.5, 0.8, 2)*sys.float_info.epsilon + 0.07, 'r')

    y = [(curve(xi)) for xi in x]

    """
    angle = [0]
    for i in range(1, len(x)):
        angle.append(np.rad2deg(np.arctan((y[i]-y[i-1])/(x[i]-x[i-1]))))

    for i in range(len(angle)-1, 1, -1):
        n = 1
        if not math.isnan(angle[i]):
            while math.isnan(angle[i-n]):
                angle[n] = angle[i]
                n += 1
    """

    flag = patches.Rectangle((0.4, 0.085), 0.1, 0.008, fc='g')
    ax.add_patch(flag)
    pole = patches.Rectangle((0.49, 0.07), 0.01, 0.023, fc='k')
    ax.add_patch(pole)

    patch = patches.Rectangle((0, 0), 0, 0, fc='c')

    def init():
        ax.add_patch(patch)
        return patch,

    def animate(i):
        patch.set_width(0.1)
        patch.set_height(0.005)
        patch.set_xy([x[i] - patch.get_width()/2, y[i]])
        #patch.angle = angle[i]
        return patch,

    anim = animation.FuncAnimation(fig, animate,
                                   init_func=init,
                                   frames=len(x),
                                   interval=10,
                                   blit=True)
    plt.show()


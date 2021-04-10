import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib import animation
# import math
import sys


def curve(fx):
    return 0.07*np.cos(2*np.pi/1.7*(fx - 0.5))


def render_mountain_car(x, block):
    fig1 = plt.figure(figsize=(10, 5))
    plt.grid()
    ax = fig1.add_subplot(111)
    ax.set_xlim(-1.5, 0.8)
    ax.set_ylim(-0.1, 0.1)
    plt.text(0.5, 0.8, f"{len(x)} actions",
             horizontalalignment='center', verticalalignment='center', transform=ax.transAxes)

    fx = np.linspace(-1.2, 0.5, 100)
    fy = curve(fx)
    plt.plot(np.linspace(-1.2, 0.5, 100), fy, 'r')
    plt.plot(np.linspace(-1.5, -1.2, 2), np.linspace(-1.5, -1.2, 2)*sys.float_info.epsilon + 0.07, 'r')
    plt.plot(np.linspace(0.5, 0.8, 2), np.linspace(0.5, 0.8, 2)*sys.float_info.epsilon + 0.07, 'r')

    y = [(curve(xi.get("position"))) for xi in x]

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
        patch.set_xy([x[i].get("position") - patch.get_width()/2, y[i]])
        #patch.angle = angle[i]
        return patch,

    anim = animation.FuncAnimation(fig1, animate,
                                   init_func=init,
                                   frames=len(x),
                                   interval=10,
                                   blit=True)

    plt.show(block=block)


def render_graph(res, display_best, block):
    fig2 = plt.figure(figsize=(10, 5))
    plt.grid()
    plt.xlabel("position")
    plt.ylabel("speed")
    plt.title(f"{display_best*'Best' + (not display_best)*'Last'} episode: actions for x, y")
    plt.legend(handles=[patches.Patch(color='red', label='action = -1'),
                        patches.Patch(color='blue', label='action = 0'),
                        patches.Patch(color='green', label='action = +1')],
               loc=1)

    xr, yr, xb, yb, xg, yg = [], [], [], [], [], []
    for i in range(len(res)):
        if res[i].get("action") == 0:
            xr.append(res[i].get("position"))
            yr.append(res[i].get("speed"))
        if res[i].get("action") == 1:
            xb.append(res[i].get("position"))
            yb.append(res[i].get("speed"))
        if res[i].get("action") == 2:
            xg.append(res[i].get("position"))
            yg.append(res[i].get("speed"))

    plt.scatter(xr, yr, c='r')
    plt.scatter(xb, yb, c='b')
    plt.scatter(xg, yg, c='g')

    plt.show(block=block)


def render_q_graph(q, position, speed, block):
    fig3 = plt.figure(figsize=(10, 5))
    ax = fig3.add_subplot(111)
    ax.set_xlim(-1.20, 0.69)
    ax.set_ylim(-0.07, 0.07)
    ax.set_xlabel("position")
    ax.set_ylabel("speed")
    ax.set_title("Q-Table: actions for x, y")
    ax.legend(handles=[patches.Patch(color='red', label='action = -1'),
                       patches.Patch(color='blue', label='action = 0'),
                       patches.Patch(color='green', label='action = +1')],
              loc=2)

    xr, yr, xb, yb, xg, yg = [], [], [], [], [], []

    p, s = None, None
    for i in range(len(position)):
        for j in range(len(speed)):
            for iteration, pos in enumerate(position):
                if iteration == i:
                    p = pos
            for iteration, spe in enumerate(speed):
                if iteration == j:
                    s = spe
            if np.argmax(q[i, j]) == 0:
                xr.append(p)
                yr.append(s)
            if np.argmax(q[i, j]) == 1:
                xb.append(p)
                yb.append(s)
            if np.argmax(q[i, j]) == 2:
                xg.append(p)
                yg.append(s)

    for i in range(len(xr)):
        patch = patches.Rectangle((xr[i], yr[i]), 0.19, 0.19, fc='r')
        ax.add_patch(patch)

    for i in range(len(xb)):
        patch = patches.Rectangle((xb[i], yb[i]), 0.19, 0.19, fc='b')
        ax.add_patch(patch)

    for i in range(len(xg)):
        patch = patches.Rectangle((xg[i], yg[i]), 0.19, 0.19, fc='g')
        ax.add_patch(patch)

    plt.show(block=block)
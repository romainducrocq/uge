import numpy as np

from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import
import matplotlib.pyplot as plt
import matplotlib.patches as patches


class Plotting:

    def __init__(self, agt, plt_data):
        self.agt = agt
        self.plt_data = plt_data

        self.range_step = 1000
        self.collision_bins = np.array(np.zeros([int(self.plt_data.get("steps")/self.range_step)]))
        for collision in self.plt_data.get("collisions"):
            self.collision_bins[int(collision/self.range_step)] += 1
        # print(self.plt_data.get("collisions"))
        # print(self.collision_bins)

    def plot_(self):
        # d: space_headway, ds: relative speed, s: speed,
        # x_y: ["s_d", "ds_s", "d_ds", "s_ds", "ds_d", "d_s"]
        q_2d = ["d_ds", "ds_d"]
        q_3d = True

        for plt_2d in q_2d:
            self.plot_q_2d_(plt_2d)

        if q_3d:
            self.plot_q_3d_()

        self.plot_data_()
        self.plot_data_tables_()

    def plot_q_2d_(self, xy_):
        m = ['o', '^', 's']
        c = ['r', 'b', 'g']

        z_ = {"s_d": 0, "ds_s": 1, "d_ds": 2, "s_ds": 0, "ds_d": 1, "d_s": 2}.get(xy_)
        flip = {"s_d": False, "ds_s": False, "d_ds": False, "s_ds": True, "ds_d": True, "d_s": True}.get(xy_)

        axes = {
            ["z", "x", "y"][np.absolute(flip*2 - z_ % 3)]: {"d": self.agt.i_dict_relative_speed, "i": 1, "c": 3.6,
                                                            "min": self.agt.bin_relative_speed.get('min'),
                                                            "max": self.agt.bin_relative_speed.get('max'),
                                                            "title": "Relative speed (km/h)"},
            ["z", "x", "y"][np.absolute(flip*2 - (z_ + 1) % 3)]: {"d": self.agt.i_dict_speed, "i": 2, "c": 3.6,
                                                                  "min": self.agt.bin_speed.get('min'),
                                                                  "max": self.agt.bin_speed.get('max'),
                                                                  "title": "Speed (km/h)"},
            ["z", "x", "y"][np.absolute(flip*2 - (z_ + 2) % 3)]: {"d": self.agt.i_dict_space_headway, "i": 0, "c": 1,
                                                                  "min": self.agt.bin_space_headway.get('min'),
                                                                  "max": self.agt.bin_space_headway.get('max'),
                                                                  "title": "Space headway (m)"},
        }

        plt.ion()
        plt.show()
        plt.style.use('seaborn')

        fig = plt.figure(figsize=(12, 6))
        fig.suptitle(f'Q-Table by acceleration [{axes.get("x").get("title")} | {axes.get("y").get("title")} | {axes.get("z").get("title")}]')

        ax = []

        n_rows = 2
        n_cols = 3

        i_q = [0, 0, 0]
        for it, z in enumerate(axes.get("z").get("d")):
            i_q[axes.get("z").get("i")] = axes.get("z").get("d").get(z)
            z = round(z * axes.get("z").get("c"), 0)

            ax.append(fig.add_subplot(n_rows, n_cols, it + 1))
            ax[-1].set_title(f'(z:) {int(z)}', fontsize=10)

            ax[-1].set_xlim(round(axes.get("x").get("min") * axes.get("x").get("c") - 5, 0),
                            round(axes.get("x").get("max") * axes.get("x").get("c") + 5, 0))
            ax[-1].set_ylim(round(axes.get("y").get("min") * axes.get("y").get("c") - 5, 0),
                            round(axes.get("y").get("max") * axes.get("y").get("c") + 5, 0))
            ax[-1].set_autoscale_on(False)
            ax[-1].set_xticks(np.linspace(round(axes.get("x").get("min") * axes.get("x").get("c"), 0),
                                          round(axes.get("x").get("max") * axes.get("x").get("c"), 0),
                                          len(axes.get("x").get("d"))))
            ax[-1].set_yticks(np.linspace(round(axes.get("y").get("min") * axes.get("y").get("c"), 0),
                                          round(axes.get("y").get("max") * axes.get("y").get("c"), 0),
                                          len(axes.get("y").get("d"))))

            for x in axes.get("x").get("d"):
                i_q[axes.get("x").get("i")] = axes.get("x").get("d").get(x)
                x = round(x * axes.get("x").get("c"), 0)
                for y in axes.get("y").get("d"):
                    i_q[axes.get("y").get("i")] = axes.get("y").get("d").get(y)
                    y = round(y * axes.get("y").get("c"), 0)
                    a = int(np.argmax(self.agt.q[i_q[0], i_q[1], i_q[2]]))
                    if not (a == 0 and self.agt.q[i_q[0], i_q[1], i_q[2], a] == 0):
                        ax[-1].scatter(x, y, marker=m[a], c=c[a], alpha=0.85)

        fig.legend(handles=[patches.Patch(color='red', label='+'),
                            patches.Patch(color='blue', label='-'),
                            patches.Patch(color='green', label='=')],
                   loc=2)

        fig.text(0.5, 0.04, f'x: {axes.get("x").get("title")}', ha='center')
        fig.text(0.04, 0.5, f'y: {axes.get("y").get("title")}', va='center', rotation='vertical')
        fig.text(0.96, 0.5, f'z: {axes.get("z").get("title")}', va='center', rotation='vertical')

        plt.show()
        plt.draw()
        plt.pause(0.001)

    def plot_q_3d_(self):
        m = ['o', '^', 's']
        c = ['r', 'b', 'g']

        plt.ion()
        plt.show()

        fig = plt.figure()
        ax = fig.add_subplot(111, projection='3d')
        for d in self.agt.i_dict_space_headway:
            i_d = self.agt.i_dict_space_headway.get(d)
            for ds in self.agt.i_dict_relative_speed:
                i_ds = self.agt.i_dict_relative_speed.get(ds)
                for s in self.agt.i_dict_speed:
                    i_s = self.agt.i_dict_speed.get(s)
                    a = int(np.argmax(self.agt.q[i_d, i_ds, i_s]))
                    if not (a == 0 and self.agt.q[i_d, i_ds, i_s, a] == 0):
                        ax.scatter(d, round(ds * 3.6, 0), round(s * 3.6, 0), marker=m[a], c=c[a])

        ax.set_xlabel('Space headway (m)')
        ax.set_ylabel('Relative Speed (km/h)')
        ax.set_zlabel('Speed (km/h)')
        ax.set_title("3D Q-Table by acceleration")
        ax.legend(handles=[patches.Patch(color='red', label='+'),
                           patches.Patch(color='blue', label='-'),
                           patches.Patch(color='green', label='=')],
                  loc=2)

        plt.show()
        plt.draw()
        plt.pause(0.001)

    def plot_data_(self):
        plt.ion()
        plt.show()
        plt.style.use('seaborn')

        fig = plt.figure(figsize=(12, 6))
        fig.suptitle('Collision and state over time')

        ax = []

        n_rows = 2
        n_cols = 2

        for i in range(4):
            ax.append(fig.add_subplot(n_rows, n_cols, i+1))

        ax[0].bar(np.linspace(0, self.plt_data.get("steps"), len(self.collision_bins)), self.collision_bins, width=1.0, facecolor='r', edgecolor='r')
        ax[0].plot(np.linspace(0, self.plt_data.get("steps"), len(self.collision_bins)), self.collision_bins, 'k--', alpha=0.5)
        ax[0].set_ylabel('Collisions')
        ax[0].set_title("Collisions per 1000 steps", fontsize=10)

        ax[1].plot(np.linspace(0, self.plt_data.get("steps"), len(self.plt_data.get("space_headway"))),
                   self.plt_data.get("space_headway"), 'k', alpha=0.85)
        ax[1].set_ylabel('Space headway (m)')
        ax[1].set_title("Space headway (m) over time", fontsize=10)

        ax[2].plot(np.linspace(0, self.plt_data.get("steps"), len(self.plt_data.get("relative_speed"))),
                   self.plt_data.get("relative_speed"), 'k', alpha=0.85)
        ax[2].set_xlabel('Simulation steps')
        ax[2].set_ylabel('Relative speed (km/h)')
        ax[2].set_title("Relative speed (km/h) over time", fontsize=10)

        ax[3].plot(np.linspace(0, self.plt_data.get("steps"), len(self.plt_data.get("speed"))),
                   self.plt_data.get("speed"), 'k', alpha=0.85)
        ax[3].set_xlabel('Simulation steps')
        ax[3].set_ylabel('Speed (km/h)')
        ax[3].set_title("Speed (km/h) over time", fontsize=10)

        plt.show()
        plt.draw()
        plt.pause(0.001)

    def plot_data_tables_(self):
        plt.ion()
        plt.show()
        plt.style.use('seaborn')

        fig = plt.figure(figsize=(12, 6))
        fig.suptitle('Collision and state over time')

        ax = []

        n_rows = 1
        n_cols = 4

        for i in range(4):
            ax.append(fig.add_subplot(n_rows, n_cols, i+1))

        cell_text = []
        total = 0
        for it, b in enumerate(self.collision_bins):
            total += b
            if it < 10 or (it < 50 and (it + 1) % 5 == 0) or (it < 100 and (it + 1) % 10 == 0):
                cell_text.append([(it+1) * self.range_step, int(b), int(total)])

        ax[0].axis('tight')
        ax[0].axis('off')
        ax[0].table(cellText=cell_text, colLabels=("Steps", "Collisions", "Total"), loc='center')
        ax[0].set_title("Collisions", fontsize=10)

        cell_text = []
        space_headway_chunks = [self.plt_data.get("space_headway")[i:i + self.range_step]
                                for i in range(0, len(self.plt_data.get("space_headway")), self.range_step)]

        for it, chunk in enumerate(space_headway_chunks):
            if it < 10 or (it < 50 and (it + 1) % 5 == 0) or (it < 100 and (it + 1) % 10 == 0):
                cell_text.append([(it+1) * self.range_step, round(float(np.mean(chunk)), 2), round(float(np.std(chunk)), 2)])

        ax[1].axis('tight')
        ax[1].axis('off')
        ax[1].table(cellText=cell_text, colLabels=("Steps", "Mean", "Std"), loc='center')
        ax[1].set_title("Space headway (m)", fontsize=10)

        cell_text = []
        relative_speed_chunks = [self.plt_data.get("relative_speed")[i:i + self.range_step]
                                 for i in range(0, len(self.plt_data.get("relative_speed")), self.range_step)]

        for it, chunk in enumerate(relative_speed_chunks):
            if it < 10 or (it < 50 and (it + 1) % 5 == 0) or (it < 100 and (it + 1) % 10 == 0):
                cell_text.append([(it+1) * self.range_step, round(float(np.mean(chunk)), 2), round(float(np.std(chunk)), 2)])

        ax[2].axis('tight')
        ax[2].axis('off')
        ax[2].table(cellText=cell_text, colLabels=("Steps", "Mean", "Std"), loc='center')
        ax[2].set_title("Relative speed (km/h)", fontsize=10)

        cell_text = []
        speed_chunks = [self.plt_data.get("speed")[i:i + self.range_step]
                        for i in range(0, len(self.plt_data.get("speed")), self.range_step)]

        for it, chunk in enumerate(speed_chunks):
            if it < 10 or (it < 50 and (it + 1) % 5 == 0) or (it < 100 and (it + 1) % 10 == 0):
                cell_text.append([(it+1) * self.range_step, round(float(np.mean(chunk)), 2), round(float(np.std(chunk)), 2)])

        ax[3].axis('tight')
        ax[3].axis('off')
        ax[3].table(cellText=cell_text, colLabels=("Steps", "Mean", "Std"), loc='center')
        ax[3].set_title("Speed (km/h)", fontsize=10)

        plt.show()
        plt.draw()
        plt.pause(0.001)

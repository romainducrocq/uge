import numpy as np
import random
import time
from plotting import Plotting


class Agent:

    def __init__(self, env):
        self.env = env
        self.reward = 1
        # self.acceleration = [1.055, 0.948, 1]
        # self.acceleration = 0.1

        # Hyper parameters
        self.alpha = 0.1
        self.gamma = 0.99
        self.epsilon = 0.1

        # bin parameters
        self.bin_space_headway = {
            "min": 0.,
            "max": 150.,
            "decimals": 0,
            "nb_values": 6
        }

        self.bin_relative_speed = {
            "min": -8.33,
            "max": 8.33,
            "decimals": 2,
            "nb_values": 6
        }

        self.bin_speed = {
            "min": 0.,
            "max": 13.89,
            "decimals": 2,
            "nb_values": 6
        }

        # index maps
        self.i_dict_space_headway = \
            dict(((round(i, self.bin_space_headway.get('decimals'))), iteration)
                 for iteration, i in
                 enumerate(np.linspace(self.bin_space_headway.get('min'),
                                       self.bin_space_headway.get('max'),
                                       self.bin_space_headway.get('nb_values'))))

        self.i_dict_relative_speed = \
            dict(((round(i, self.bin_relative_speed.get('decimals'))), iteration)
                 for iteration, i in
                 enumerate(np.linspace(self.bin_relative_speed.get('min'),
                                       self.bin_relative_speed.get('max'),
                                       self.bin_relative_speed.get('nb_values'))))

        self.i_dict_speed = \
            dict(((round(i, self.bin_speed.get('decimals'))), iteration)
                 for iteration, i in
                 enumerate(np.linspace(self.bin_speed.get('min'),
                                       self.bin_speed.get('max'),
                                       self.bin_speed.get('nb_values'))))

        self.action = [1, -1, 0]
        self.i_dict_action = \
            dict((i, iteration)
                 for iteration, i in enumerate(self.action))

        # Q table
        self.q = np.array(np.zeros([len(self.i_dict_space_headway),
                                    len(self.i_dict_relative_speed),
                                    len(self.i_dict_speed),
                                    len(self.i_dict_action)]))

    def set_reward_collision(self, reward_type):
        # self.reward -= 10
        # self.reward /= 10
        # self.reward = 0
        # pass
        if reward_type == "collision":
            self.reward -= 10
        # elif reward_type == "horizon":
        #     pass
        elif reward_type == "security_distance":
            self.reward = 0

    """
    def set_reward_horizon_speed(self, space_headway, speed, speed_limit):
        if speed_limit and speed > round(self.bin_speed.get('max') + (1 / 3.6) * 5, 2):
            self.reward /= 10
        else:
            self.reward += np.min([1, np.max([0, round(1 - space_headway/1000., 1)])])
            print(f"dist: {space_headway}")
        self.reward = round(self.reward, 1)
    """

    def set_reward_security_dist_speed(self, space_headway, speed, speed_limit):
        if speed_limit and speed > round(self.bin_speed.get('max') + (1 / 3.6) * 5, 2):
            self.reward /= 10
        else:
            dist = np.absolute(np.min([round(space_headway, 0), self.bin_space_headway.get('max')])
                               - self.env.get_follower(self.env.my_car_id, self.bin_space_headway.get('max')))
            self.reward += (self.bin_space_headway.get('max') - dist) / self.bin_space_headway.get('max')
            print(f"dist: {dist}")
        self.reward = round(self.reward, 2)

    def new_speed(self, a, speed):
        print(f"action : {a}")
        return np.max([self.bin_speed.get('min'), speed + a])

    def epsilon_decay(self, step):
        if step % 1000 == 0:
            self.epsilon = round(self.epsilon * 0.9, 6)

    def e_greedy_policy(self, d_t, ds_t, s_t):
        if random.uniform(0, 1) < self.epsilon:
            return random.randint(0, 2)
        else:
            return np.argmax(self.q[
                self.i_dict_space_headway.get(d_t),
                self.i_dict_relative_speed.get(ds_t),
                self.i_dict_speed.get(s_t)])

    def framing(self, val, i_dict):
        i_lower, i_max, i_min = None, np.NINF, np.inf

        for i in i_dict:
            if i > i_max:
                i_max = i
            if i < i_min:
                i_min = i
            if val >= i:
                i_lower = i
            if i_min <= val < i:
                if (val - i_lower) >= (i - i_lower) / 2:
                    val = i
                else:
                    val = i_lower
                break

        return np.min([i_max, np.max([i_min, val])])

    def training(self, episodes):
        self.env.set_speed_mode(self.env.my_car_id, 0)
        state = None
        steps = 0

        # reward_type = "collision"
        # reward_type = "horizon"
        reward_type = "security_distance"
        speed_limit = True

        plt_data = {
            "collisions": [], "space_headway": [], "relative_speed": [], "speed": [], "steps": 0
        }

        while True:
            print(state)
            if state:
                plt_data["space_headway"].append(state.get("space_headway"))
                plt_data["relative_speed"].append(round(state.get("relative_speed") * 3.6, 0))
                plt_data["speed"].append(round(state.get("speed") * 3.6, 0))

                d_t, ds_t, s_t = \
                    self.framing(state.get('space_headway'), self.i_dict_space_headway), \
                    self.framing(state.get('relative_speed'), self.i_dict_relative_speed), \
                    self.framing(state.get('speed'), self.i_dict_speed)

                a = self.e_greedy_policy(d_t, ds_t, s_t)

                q_t = self.q[
                    self.i_dict_space_headway.get(d_t),
                    self.i_dict_relative_speed.get(ds_t),
                    self.i_dict_speed.get(s_t),
                    self.i_dict_action.get(self.action[a])]

                new_speed = self.new_speed(self.action[a], state.get('speed'))
                self.env.set_speed(self.env.my_car_id, new_speed)
                self.env.simulation_step()
                next_state = self.env.get_state(self.env.my_car_id)

                q_max_t1 = None
                if self.env.is_collided(self.env.my_car_id):
                    self.set_reward_collision(reward_type)
                    self.env.set_speed(self.env.my_car_id, 0)
                    q_max_t1 = 0
                    state = None
                    plt_data["collisions"].append(steps)

                elif next_state:
                    """REWARD"""
                    """
                    if reward_type == "horizon":
                        self.set_reward_horizon_speed(next_state.get('space_headway'), next_state.get('speed'), speed_limit)
                    """

                    if reward_type == "security_distance":
                        self.set_reward_security_dist_speed(next_state.get('space_headway'), next_state.get('speed'), speed_limit)

                    print(f"reward {self.reward}")

                    d_t1, ds_t1, s_t1 = \
                        self.framing(next_state.get('space_headway'), self.i_dict_space_headway), \
                        self.framing(next_state.get('relative_speed'), self.i_dict_relative_speed), \
                        self.framing(next_state.get('speed'), self.i_dict_speed)

                    q_max_t1 = np.max(self.q[
                                          self.i_dict_space_headway.get(d_t1),
                                          self.i_dict_relative_speed.get(ds_t1),
                                          self.i_dict_speed.get(s_t1)])

                    state = next_state

                if q_max_t1 is not None:
                    self.q[
                        self.i_dict_space_headway.get(d_t),
                        self.i_dict_relative_speed.get(ds_t),
                        self.i_dict_speed.get(s_t),
                        self.i_dict_action.get(self.action[a])] = \
                        (1 - self.alpha) * q_t + self.alpha * (self.reward + self.gamma * q_max_t1)

                    """ PRINT Q"""
                    print(f"q: {self.q[self.i_dict_space_headway.get(d_t), self.i_dict_relative_speed.get(ds_t), self.i_dict_speed.get(s_t)]}")

                steps += 1
                self.epsilon_decay(steps)
                # print(steps)
                # print(f"time: {self.env.get_current_time()}")
            else:
                self.env.simulation_step()
                state = self.env.get_state(self.env.my_car_id)
                self.env.set_speed(self.env.my_car_id, 0)

            if steps > (episodes * 10000):
                time.sleep(.1)

            if steps == episodes * 10000:
                plt_data["steps"] = steps
                plotting = Plotting(self, plt_data)
                plotting.plot_()

    """
    TEST FUNCTIONS
    """
    def print_indexes(self):
        print(f"space_headway:\n {self.i_dict_space_headway}")
        print(f"relative_speed:\n {self.i_dict_relative_speed}")
        print(f"speed:\n {self.i_dict_speed}")
        print(f"actions:\n {self.i_dict_action}")
        print(f"q size: {self.q.shape}")
        print(f"q total size: {len(self.q)*len(self.q[0])*len(self.q[0][0])*len(self.q[0][0][0])}")
        exit()

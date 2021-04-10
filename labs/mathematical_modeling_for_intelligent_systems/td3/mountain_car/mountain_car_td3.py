#!/usr/bin/python3

import numpy as np
import random

import plotting

position_round, speed_round = 10, 10
position_nb_values, speed_nb_values = 10, 10


def next_state(xt, vt, at):
    vt1 = vt + 0.001*at - 0.0025*np.cos(3*xt)
    vt1 = round(vt1, speed_round)
    vt1 = np.min([0.07, np.max([-0.07, vt1])])

    xt1 = xt + vt1
    xt1 = round(xt1, position_round)
    xt1 = np.min([0.5, np.max([-1.2, xt1])])

    if xt1 <= -1.2:
        vt1 = 0

    return xt1, vt1


def e_greedy_policy(xt, vt):
    if random.uniform(0, 1) < epsilon:
        return action[random.randint(1, 3) - 1]
    else:
        return action[np.argmax(q[index_map_position.get(xt), index_map_speed.get(vt)])]


def framing(val, dict_):
    i_lower = None

    for i in dict_:
        if val >= i:
            i_lower = i
        if val < i:
            if (val - i_lower) >= (i-i_lower)/2:
                val = i
            else:
                val = i_lower
            break

    return val


def hyper_parameter_decay(alpha_, gamma_, epsilon_, ep):

    # alpha_ -= (0.1-0.01)/episodes
    # alpha_ = np.min([1, np.max([0.01, alpha_])])
    """
    gamma_ = 
    gamma_ = np.min([1, np.max([0.1, gamma_])])
    """
    # epsilon_ -= (0.1-0.01)/episodes
    epsilon_ = episodes / (ep*100)
    epsilon_ = np.min([0.1, np.max([0.01, epsilon_])])

    return alpha_, gamma_, epsilon_


index_map_position = \
    dict(((round(i, position_round)), iteration)
         for iteration, i in enumerate(np.arange(-1.2, 0.5+10**(-position_round), 1.7/(position_nb_values - 1))))

index_map_speed = \
    dict(((round(i, speed_round)), iteration)
         for iteration, i in enumerate(np.arange(-0.07, 0.07 + 10 ** (-speed_round), 0.14/(speed_nb_values - 1))))

action = [-1, 0, 1]
index_map_action = \
    dict((i, iteration)
         for iteration, i in enumerate(action))

"""
for i in index_map_position:
    print(i)
print("")
for i in index_map_speed:
    print(i)
print("")
a = framing(0, index_map_position)
print(a)

exit()
"""
"""
print(index_map_position)
print(len(index_map_position))
print(index_map_speed)
print(len(index_map_speed))
print(index_map_action)
print(len(action))

exit()
"""

episodes = 2500
max_steps = 200

# Hyper parameters
alpha = 0.1
gamma = 0.99
epsilon = 0.1

q = np.array(np.zeros([len(index_map_position), len(index_map_speed), len(index_map_action)]))

# For animation
res = None

for e in range(episodes):
    x, v = -0.5, 0.
    reward = 0
    done = False

    alpha, gamma, epsilon = hyper_parameter_decay(alpha, gamma, epsilon, e + 1)
    i = 0
    # For animation
    res_tmp = [-0.5]
    while not done:
        reward -= 1

        x_, v_ = framing(x, index_map_position), framing(v, index_map_speed)
        a = e_greedy_policy(x_, v_)
        x1, v1 = next_state(x, v, a)
        x1_, v1_ = framing(x1, index_map_position), framing(v1, index_map_speed)

        next_max = np.max(q[index_map_position.get(x1_), index_map_speed.get(v1_)])
        q[index_map_position.get(x_), index_map_speed.get(v_), index_map_action.get(a)] = \
            (1 - alpha) * q[index_map_position.get(x_), index_map_speed.get(v_), index_map_action.get(a)] \
            + alpha * (reward + gamma * next_max)
        x, v = x1, v1

        i += 1

        if i + 1 == max_steps:
            done = True
            # print(f"Episode {e+1}: fail")

        if x >= 0.5:
            done = True
            print(f"Episode {e+1}: {i+1} actions")
            # For animation
            res = res_tmp

        # For animation
        # if e == episodes-1:
        res_tmp.append(x)

print("done")

plotting.render_mountain_car(res)






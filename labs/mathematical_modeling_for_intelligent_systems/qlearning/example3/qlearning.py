#!/usr/bin/python3

# https://blog.floydhub.com/an-introduction-to-q-learning-reinforcement-learning/

import os
import sys
import numpy as np
from QAgent import QAgent

os.system("clear")

start, end, it = 'L4', 'L6', 1000

if len(sys.argv) == 3:
    if 1 <= int(sys.argv[1]) <= 9 and 1 <= int(sys.argv[2]) <= 9:
        start, end = 'L' + str(sys.argv[1]), 'L' + str(sys.argv[2])

# Print map
print("+--------------+")
print("| L1   L2   L3 |")
print("+----+    +    |")
print("| L4 | L5 | L6 |")
print("|    +    +----|")
print("| L7   L8   L9 |")
print("+--------------+")
print("\n")
print(f"From {start} to {end}:")

# Define the states
location_to_state = {
    'L1': 0,
    'L2': 1,
    'L3': 2,
    'L4': 3,
    'L5': 4,
    'L6': 5,
    'L7': 6,
    'L8': 7,
    'L9': 8
}

# Maps indices to locations
state_to_location = dict((state, location) for location, state in location_to_state.items())

# Define the actions
actions = [0, 1, 2, 3, 4, 5, 6, 7, 8]

rewards = np.array([
    [0, 1, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 1, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 1, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0]
])

# Initialize parameters
learning_rate = 0.9
discount_factor = 0.75

# Initialize q-values
q = np.array(np.zeros([9, 9]))

q_agent = QAgent(learning_rate, discount_factor, location_to_state, actions, rewards, state_to_location, q)
q_agent.training(start, end, it)

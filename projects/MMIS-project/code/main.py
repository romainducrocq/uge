#!/usr/bin/python3

# Project: Learn to drive
# Mathematical modeling for intelligent systems
# UGE - Université Gustave Eiffel
# M2 SIA - Systèmes intelligents et Applications
# 2020 - Fall Semester

# @author  Romain DUCROCQ

import sys
from env import Env
from agent import Agent

# {1:10} # In tens of thousands of simulation steps
duration = 5
# {3:50}
cars = 50


if len(sys.argv) == 3 or len(sys.argv) == 5:
    if (sys.argv[1] == "-c" or sys.argv[1] == "--cars") and sys.argv[2].isdigit() and 3 <= int(sys.argv[2]) <= 50:
        cars = int(sys.argv[2])
    if (sys.argv[1] == "-d" or sys.argv[1] == "--duration") and sys.argv[2].isdigit() and 1 <= int(sys.argv[2]) <= 10:
        duration = int(sys.argv[2])
    if len(sys.argv) == 5:
        if (sys.argv[3] == "-c" or sys.argv[3] == "--cars") and sys.argv[4].isdigit() and 3 <= int(sys.argv[4]) <= 50:
            cars = int(sys.argv[4])
        if (sys.argv[3] == "-d" or sys.argv[3] == "--duration") and sys.argv[4].isdigit() and 1 <= int(sys.argv[4]) <= 10:
            duration = int(sys.argv[4])


if __name__ == "__main__":

    sys.argv = [sys.argv[0]]

    print(f"{cars} cars, {duration}0000 simulation steps")

    env = Env('data/circle.net.xml', cars)

    agent = Agent(env)

    # agent.print_indexes()

    agent.training(duration)

    env.simulation_close()


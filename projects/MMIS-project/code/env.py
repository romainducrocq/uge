#!/usr/bin/python3

from __future__ import absolute_import
from __future__ import print_function

import os
import sys
import optparse
import numpy as np

if 'SUMO_HOME' in os.environ:
    tools = os.path.join(os.environ['SUMO_HOME'], 'tools')
    sys.path.append(tools)
else:
    sys.exit("please declare environment variable 'SUMO_HOME'")

from sumolib import checkBinary, net  # noqa
import traci  # noqa


class Env:

    def __init__(self, network, nb_cars):
        self.network = net.readNet(network)

        self.nb_cars = nb_cars
        self.my_car_id = "my_car"
        # self.front_car_id = "front_car"

        self.generate_route_file()
        options = self.get_options()
        params = self.set_params(options)
        traci.start(params)

    def set_speed_mode(self, car_id, mode):
        traci.vehicle.setSpeedMode(car_id, mode)
        """
        bit0: Regard safe speed
        bit1: Regard maximum acceleration
        bit2: Regard maximum deceleration
        bit3: Regard right of way at intersections
        bit4: Brake hard to avoid passing a red light
    
        all checks off -> [0 0 0 0 0] -> Speed Mode = 0
        disable right of way check -> [1 0 1 1 1] -> Speed Mode = 23
        all checks on -> [1 1 1 1 1] -> Speed Mode = 31
        run a red light [0 0 1 1 1] = 7 (also requires setSpeed or slowDown)
        """

    def set_speed(self, car_id, speed):
        traci.vehicle.setSpeed(car_id, speed)

    def get_position(self, car_id):
        return traci.vehicle.getPosition(car_id)

    def get_distance(self, position_1, position_2):
        return np.sqrt(np.power(position_1[0] - position_2[0], 2)
                       + np.power(position_1[1] - position_2[1], 2))

    """
    def get_distance_circular_segment(self, car1_id, car2_id):
        r = 500
        chord = self.get_distance(self.get_position(car1_id), self.get_position(car2_id))

        if traci.vehicle.getRoadID(car1_id) == traci.vehicle.getRoadID(car2_id):
            return chord

        angle = 2*np.arcsin(chord/(2*r))
        circular_segment = r*angle

        return circular_segment
    """

    def get_leader_on_edge(self, car_id):
        return traci.vehicle.getLeader(car_id, dist=0.0)

    def get_follower(self, car_id, horizon):
        follower_dist = traci.vehicle.getFollower(car_id, dist=0.0)[1]
        return np.min([round(follower_dist, 0), horizon]) if follower_dist > 0 else horizon

    def get_edge_id(self, car_id):
        return traci.vehicle.getRoadID(car_id)

    def get_next_edge(self, edge_id):
        outgoing_edges = list(self.network.getEdge(edge_id).getOutgoing().keys())[0]
        return {
            "id": outgoing_edges.getID(),
            "from": outgoing_edges.getFromNode().getID(),
            "to": outgoing_edges.getToNode().getID()
        }

    def get_nb_cars_on_edge(self, edge_id):
        try:
            return traci.edge.getLastStepVehicleNumber(edge_id)
        except traci.exceptions.TraCIException as e:
            print(e)
            return None

    def get_edges_until_leader(self, car_id):
        e, next_edge, is_car_on_next_edge, edges = None, None, None, []
        e = self.get_edge_id(car_id)
        if e and not e[0] == ':':
            next_edge = self.get_next_edge(e)
            while not is_car_on_next_edge:
                edges.append(next_edge)
                is_car_on_next_edge = self.get_nb_cars_on_edge(next_edge.get("id"))
                next_edge = self.get_next_edge(next_edge.get("id"))
        return edges

    def get_cars_on_edge(self, edge_id):
        try:
            return traci.edge.getLastStepVehicleIDs(edge_id)
        except traci.exceptions.TraCIException as e:
            print(e)
            return None

    def get_leader_on_next_edge_id(self, edges):
        if edges:
            return self.get_cars_on_edge(edges[-1].get("id"))[0]
        else:
            return None

    def get_node_position(self, node_id):
        return traci.junction.getPosition(node_id)

    def get_leader_on_next_edge_distance(self, car_1_id, car_2_id, edges):
        if car_1_id and car_2_id and edges:
            distance = self.get_distance(self.get_position(car_1_id),
                                         self.get_node_position(edges[0].get("from")))
            for i in range(len(edges)):
                if i < len(edges) - 1:
                    distance += self.get_distance(self.get_node_position(edges[i].get("from")),
                                                  self.get_node_position(edges[i].get("to")))
                else:
                    distance += self.get_distance(self.get_node_position(edges[i].get("from")),
                                                  self.get_position(car_2_id))
            return distance
        else:
            return None

    def get_leader(self, car_id):
        leader = {'id': None, 'distance': None}
        leader_on_edge = self.get_leader_on_edge(car_id)
        if leader_on_edge:
            leader['id'] = leader_on_edge[0]
            leader['distance'] = leader_on_edge[1]
        else:
            edges = self.get_edges_until_leader(car_id)
            leader['id'] = self.get_leader_on_next_edge_id(edges)
            leader['distance'] = self.get_leader_on_next_edge_distance(car_id, leader.get('id'), edges)
        return leader

    def get_speed(self, car_id):
        return traci.vehicle.getSpeed(car_id)

    def get_relative_speed(self, car1_id, car2_id):
        return self.get_speed(car1_id) - self.get_speed(car2_id)

    def get_state(self, car_id):
        """
        speed (speed(0))
            - values: [0km/h,100km/h], unit: 1km/h
        """
        """
        relative speed (speed(1)-speed(2))
            - values: [-30km/h,30km/h], unit: 1km/h
        """
        """
        space headway (position(1)-position(0))
            - values: [0m,100m], unit: 1m
        """
        leader = self.get_leader(car_id)
        if leader.get('id') and leader.get('distance'):
            return {
                "speed": round(self.get_speed(car_id), 2),
                "relative_speed": round(self.get_relative_speed(car_id, leader.get('id')), 2),
                "space_headway": round(leader.get('distance'), 0)
            }
        else:
            return None

    def get_collisions(self):
        return traci.simulation.getCollidingVehiclesIDList()

    def is_collided(self, car_id):
        return car_id in self.get_collisions()

    def get_current_time(self):
        return traci.simulation.getCurrentTime()

    def reset(self):
        pass

    def simulation_step(self):
        traci.simulationStep()

    def simulation_close(self):
        traci.close()
        sys.stdout.flush()

    def generate_route_file(self):
        with open("data/circle.rou.xml", "w") as routes:
            print('<routes>', file=routes)
            print(' <vType accel="2.9" decel="7.5" id="npc_car" type="passenger" length="4.3" minGap="30" maxSpeed="13.89" sigma="0.5" />', file=routes)
            print(' <vType accel="2.9" decel="7.5" id="ai_car" type="passenger" length="4.3" minGap="0" maxSpeed="27.89" departspeed="0" sigma="0.5" />', file=routes)
            print(' <route id="circle_route" edges="1to2 2to3"/>', file=routes)
            # print(f' <vehicle depart="0" id="{self.front_car_id}" route="circle_route" type="npc_car" color="0,0,1" />', file=routes)
            # print(f' <vehicle depart="0" id="{self.my_car_id}" route="circle_route" type="ai_car" color="1,0,0" />', file=routes)
            print(f' <flow id="carflow" type="npc_car" beg="0" end="0" number="{str(self.nb_cars-1)}" from="1to2" to="2to3"/>', file=routes)
            print(f' <vehicle depart="1" id="{self.my_car_id}" route="circle_route" type="ai_car" color="1,0,0" />', file=routes)
            print('</routes>', file=routes)

    def get_options(self):
        opt_parser = optparse.OptionParser()
        opt_parser.add_option("--nogui", action="store_true",
                              default=False, help="run the commandline version of sumo")

        opt_parser.add_option('--log', action="store_true",
                              default=False, help="verbose warning & error log to file")

        opt_parser.add_option('--debug', action="store_true",
                              default=False, help="run the debug mode")

        opt_parser.add_option('--remote', action="store_true",
                              default=False, help="run remote")

        opt, args = opt_parser.parse_args()
        return opt

    def set_params(self, options):
        if options.nogui:
            sumo_binary = checkBinary('sumo')
        else:
            sumo_binary = checkBinary('sumo-gui')

        params = [sumo_binary, "-c", "data/circle.sumocfg"]

        if not options.nogui:
            params.append("-S")
            params.append("--gui-settings-file")
            params.append("data/gui-settings.cfg")
            # params.append("-v")

        if options.log:
            params.append("--message-log")
            params.append("log/message_log")

        if options.debug:
            params.append("--save-configuration")
            params.append("debug/debug.sumocfg")

        if options.remote:
            params.append("--remote-port")
            params.append("9999")
            traci.init(9999)

        return params

import numpy as np


class QAgent:
    def __init__(self, learning_rate, discount_factor, location_to_state, actions, rewards, state_to_location, q):
        self.learning_rate = learning_rate
        self.discount_factor = discount_factor

        self.location_to_state = location_to_state
        self.actions = actions
        self.rewards = rewards
        self.state_to_location = state_to_location

        self.q = q

    def training(self, start_location, end_location, iterations):
        # Copy the reward matrix to new matrix
        rewards_new = np.copy(self.rewards)

        # Get the ending state corresponding to the ending location as given
        ending_state = self.location_to_state[end_location]

        # With the above information automatically set the priority of the
        # given ending state to the highest one
        rewards_new[ending_state, ending_state] = 999

        # ----------Q-learning algorithm----------

        for i in range(iterations):
            # Pick a state randomly
            # Python excludes the upper bound
            current_state = np.random.randint(0, 9)
            # For traversing through the neighbor locations in the maze
            playable_actions = []
            # Iterate through the new rewards matrix and get the actions > 0
            for j in range(9):
                if rewards_new[current_state, j] > 0:
                    playable_actions.append(j)
            # Pick an action randomly from the list of playable leading
            # us to the next state
            next_state = np.random.choice(playable_actions)
            # Compute the temporal difference TD
            # The action here exactly refers to going to the next state
            td = rewards_new[current_state, next_state] \
                + self.discount_factor * self.q[next_state, np.argmax(self.q[next_state, ])] \
                - self.q[current_state, next_state]
            # Update the q-value using the bellman equation
            self.q[current_state, next_state] += self.learning_rate * td

        # Initialize the optimal route with the starting location
        route = [start_location]

        next_location = start_location

        # Get the route
        self.get_optimal_route(start_location, end_location, next_location, route, self.q)

    def get_optimal_route(self, start_location, end_location, next_location, route, q):
        while next_location != end_location:
            # Fetch the starting state
            starting_state = self.location_to_state[start_location]
            # Fetch the highest q_value pertaining to a starting state
            next_state = np.argmax(q[starting_state, ])
            # We got the index of the next state, but we need the
            # corresponding letter
            next_location = self.state_to_location[next_state]
            route.append(next_location)
            # Update the starting location for the next iteration
            start_location = next_location

        print(route)

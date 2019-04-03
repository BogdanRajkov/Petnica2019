import numpy as np
from numpy.linalg import norm
from numpy import array as arr
import matplotlib.pyplot as plt

import parameters as par
from parameters import no_rays, step
from config import permittivity


def hamiltonian(position, kvector):
    n = 1 / norm(permittivity(position))
    return par.c * np.sqrt(np.dot(kvector, kvector)) / n


def partial_der_q(position, kvector, delta):
    return (hamiltonian(position+delta, kvector) - hamiltonian(position-delta, kvector)) \
           / (2 * norm(delta))


def partial_der_k(position, kvector, delta):
    return (hamiltonian(position, kvector+delta) - hamiltonian(position, kvector-delta)) \
           / (2 * norm(delta))


def propagate(position, kvector):
    k1_k = -step * arr([partial_der_q(position, kvector, arr([step, 0])),
                        partial_der_q(position, kvector, arr([0, step]))])
    k1_q =  step * arr([partial_der_k(position, kvector, arr([step, 0])),
                        partial_der_k(position, kvector, arr([0, step]))])
    k2_k = -step * arr([partial_der_q(position + k1_q / 2, kvector + k1_k / 2, arr([step, 0])),
                        partial_der_q(position + k1_q / 2, kvector + k1_k / 2, arr([0, step]))])
    k2_q =  step * arr([partial_der_k(position + k1_q / 2, kvector + k1_k / 2, arr([step, 0])),
                        partial_der_k(position + k1_q / 2, kvector + k1_k / 2, arr([0, step]))])
    k3_k = -step * arr([partial_der_q(position + k2_q / 2, kvector + k2_k / 2, arr([step, 0])),
                        partial_der_q(position + k2_q / 2, kvector + k2_k / 2, arr([0, step]))])
    k3_q =  step * arr([partial_der_k(position + k2_q / 2, kvector + k2_k / 2, arr([step, 0])),
                        partial_der_k(position + k2_q / 2, kvector + k2_k / 2, arr([0, step]))])
    k4_k = -step * arr([partial_der_q(position + k3_q, kvector + k3_k, arr([step, 0])),
                        partial_der_q(position + k3_q, kvector + k3_k, arr([0, step]))])
    k4_q =  step * arr([partial_der_k(position + k3_q, kvector + k3_k, arr([step, 0])),
                        partial_der_k(position + k3_q, kvector + k3_k, arr([0, step]))])
    new_position = position + (k1_q + 2 * k2_q + 2 * k3_q + k4_q) / 6
    new_kvector = kvector + (k1_k + 2 * k2_k + 2 * k3_k + k4_k) / 6
    return new_position, new_kvector


def main():
    # generate y coordinates for rays we'll plot
    start_y = np.linspace(-par.ray_distance * (no_rays - 1) / 2,
                          par.ray_distance * (no_rays - 1) / 2,
                          no_rays)
    # generate start positions for rays we'll plot
    start_positions = arr([-np.ones(no_rays)*par.ray_boundaries[0], start_y]).T

    for i in range(no_rays):
        position, kvector = start_positions[i], par.start_kvector
        position_arr = [position]
        kvector_arr = [kvector]
        # variables ending with '_arr' are used for storing respective variables as they change
        while np.all(np.abs(position) <= par.ray_boundaries):
            # print(position)
            position, kvector = propagate(position, kvector)
            position_arr.append(position)
            kvector_arr.append(kvector)
        position_arr = arr(position_arr)
        kvector_arr = arr(kvector_arr)
        print(position_arr)
        print(kvector_arr)
        plt.plot(position_arr[:][0], position_arr[:][1])
        plt.show()


if __name__ == "__main__":
    main()

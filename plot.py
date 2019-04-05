import numpy as np
from numpy.linalg import norm
from numpy import array as arr
import matplotlib.pyplot as plt

import parameters as par
from parameters import no_rays, step
from config import black_hole as permittivity


def hamiltonian(position, kvector):
    n = norm(permittivity(position))
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
    # start_y = np.linspace(-par.ray_distance * (no_rays - 1) / 2,
    # par.ray_distance * (no_rays - 1) / 2,
    # no_rays)
    # generate start positions for rays we'll plot
    # start_positions = arr([-np.ones(no_rays)*par.ray_boundaries[0], start_y]).T
    start_positions = arr([[-par.ray_boundaries[0], 4.5]])

    for i in range(no_rays):
        position, kvector = start_positions[i], par.start_kvector
        position_arr = [position]
        kvector_arr = [kvector]
        # variables ending with '_arr' are used for storing respective variables as they change
        while np.all(np.abs(position) <= par.ray_boundaries) and norm(position) > 1:
            # print(position)
            position, kvector = propagate(position, kvector)
            position_arr.append(position)
            kvector_arr.append(kvector)
        position_arr = arr(position_arr).T
        kvector_arr = arr(kvector_arr).T
        print(position_arr)
        print(kvector_arr)
        plt.plot(position_arr[0], position_arr[1])
        # theta1 = np.arctan2(kvector_arr[1][0], kvector_arr[0][0])
        # theta2 = np.arctan2(kvector_arr[1][-1], kvector_arr[0][-1])
        # print(np.sin(theta1), np.sin(theta2))

    x1 = np.linspace(-1, 1, 500)
    k1 = [np.sqrt(1 - el**2) for el in x1]
    x2 = np.linspace(-5, 5, 1000)
    k2 = [np.sqrt(5**2 - el**2) for el in x2]
    plt.plot(x1, k1, 'k')
    plt.plot(x2, k2, 'k')
    plt.axis('scaled')
    plt.suptitle('Opticka crna rupa')
    plt.show()


if __name__ == "__main__":
    main()

import numpy as np


def permittivity(position):
    if position[0] > 0:
        return np.array([1.33, 1])
    else:
        return np.array([1, 1])

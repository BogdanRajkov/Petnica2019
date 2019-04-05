import numpy as np
from numpy.linalg import norm


def plane(position):
    if position[0] > 0:
        return np.array([3, 1])
    else:
        return np.array([1, 1])


def layer(position):
    if position[0] > 0.1 or position[0] < -0.1:
        return np.array([1, 1])
    else:
        return np.array([3, 1])


def cloak(position):
    r1, r2 = 3, 7
    if norm(position) > r2 or norm(position) < r1:
        return np.array([1, 1])
    else:
        return np.array([1, 1])


def black_hole(position):
    r1, r2 = 1, 5
    if r1 < norm(position) < r2:
        return np.array([(r2 / norm(position)) ** 2, 1])
    else:
        return np.array([1, 1])

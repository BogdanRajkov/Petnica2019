function [new_intensity, new_position, new_kvector] = propagate(intensity, position, kvector)
    step = 2e-4;
    k1_k1 = partial_q(position, kvector, [step 0]);
    k1_k2 = partial_q(position, kvector, [0 step]);
    k1_k = -step * [k1_k1 k1_k2];
    k1_q1 = partial_k(position, kvector, [step 0]);
    k1_q2 = partial_k(position, kvector, [0 step]);
    k1_q =  step * [k1_q1 k1_q2];
    k2_k1 = partial_q(position + k1_q / 2, kvector + k1_k / 2, [step 0]);
    k2_k2 = partial_q(position + k1_q / 2, kvector + k1_k / 2, [0 step]);
    k2_k = -step * [k2_k1 k2_k2];
    k2_q1 = partial_k(position + k1_q / 2, kvector + k1_k / 2, [step 0]);
    k2_q2 = partial_k(position + k1_q / 2, kvector + k1_k / 2, [0 step]);
    k2_q =  step * [k2_q1 k2_q2];
    k3_k1 = partial_q(position + k2_q / 2, kvector + k2_k / 2, [step 0]);
    k3_k2 = partial_q(position + k2_q / 2, kvector + k2_k / 2, [0 step]);
    k3_k = -step * [k3_k1 k3_k2];
    k3_q1 = partial_k(position + k2_q / 2, kvector + k2_k / 2, [step 0]);
    k3_q2 = partial_k(position + k2_q / 2, kvector + k2_k / 2, [0 step]);
    k3_q =  step * [k3_q1 k3_q2];
    k4_k1 = partial_q(position + k3_q, kvector + k3_k, [step 0]);
    k4_k2 = partial_q(position + k3_q, kvector + k3_k, [0 step]);
    k4_k = -step * [k4_k1 k4_k2];
    k4_q1 = partial_k(position + k3_q, kvector + k3_k, [step 0]);
    k4_q2 = partial_k(position + k3_q, kvector + k3_k, [0 step]);
    k4_q =  step * [k4_q1 k4_q2];
    new_intensity = intensity;
    new_position = position + (k1_q + 2 * k2_q + 2 * k3_q + k4_q) / 6;
    new_kvector = kvector  + (k1_k + 2 * k2_k + 2 * k3_k + k4_k) / 6;
end

function [pder] = partial_q(position, kvector, delta)
    pder = (hamiltonian(position+delta, kvector) - hamiltonian(position-delta, kvector))/(2 * norm(delta));
end

function [pder] = partial_k(position, kvector, delta)
    pder = (hamiltonian(position, kvector+delta) - hamiltonian(position, kvector-delta))/(2 * norm(delta));
end

function [haml] = hamiltonian(position, kvector)
    n = sqrt(prod(permittivity(position)));
    haml = norm(kvector) / n;
end
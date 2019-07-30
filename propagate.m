function [new_intensity, new_position, new_kvector] = propagate(intensity, position, kvector)
    k1_k = -korak * partial_q(position, kvector, korak);
    k1_q =  korak * partial_k(position, kvector, korak);
    k2_k = -korak * partial_q(position + k1_q/2, kvector + k1_k/2, korak);
    k2_q =  korak * partial_k(position + k1_q/2, kvector + k1_k/2, korak);
    k3_k = -korak * partial_q(position + k2_q/2, kvector + k2_k/2, korak);
    k3_q =  korak * partial_k(position + k2_q/2, kvector + k2_k/2, korak);
    k4_k = -korak * partial_q(position + k3_q, kvector + k3_k, korak);
    k4_q =  korak * partial_k(position + k3_q, kvector + k3_k, korak);
    new_intensity = intensity;
    new_position = position + (k1_q + 2 * k2_q + 2 * k3_q + k4_q) / 6;
    new_kvector = kvector  + (k1_k + 2 * k2_k + 2 * k3_k + k4_k) / 6;
end

function pder = partial_q(position, kvector, korak)
    pder = (norm(kvector) / (2 * korak)) * [1/index(position+[korak 0]) - 1/index(position-[korak 0]) 1/index(position+[0 korak]) - 1/index(position-[0 korak])];
end

function pder = partial_k(position, kvector, korak)
    pder = [norm(kvector+[korak 0]) - norm(kvector-[korak 0]) norm(kvector+[0 korak]) - norm(kvector-[0 korak])] / (2 * korak * index(position));
end
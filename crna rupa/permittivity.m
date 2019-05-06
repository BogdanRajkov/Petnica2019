function [ perm ] = permittivity(position)
    if norm(position) > 5
        perm = [1 1];
    else
        perm = [(5 / norm(position)) ^ 2, 1];
    end
end


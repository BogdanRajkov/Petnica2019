function [ perm ] = permittivity( position )
    if position(1) < 0
        perm = [100, 1];
    else
        perm = [1, 1];
    end    
end


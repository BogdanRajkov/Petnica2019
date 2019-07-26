function [ perm ] = permittivity(position)
    if norm(position) > 5
        perm = [1 1];
    else
        n=2;
        for i=0:n
            if norm(position) > 5*i/n && norm(position) <= 5*(i+1)/n
                perm=[(n-i+1)^3, 1];
            end
        end
    end  
end
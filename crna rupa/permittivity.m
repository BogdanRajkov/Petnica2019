function [ perm ] = permittivity(position)
     if norm(position) > 5
         perm = [1 1];
     else
         n=10;
          for i=1:n
          if norm(position) > 5*i/n
              if norm(position)<5*(i+1)/n
               perm=[(n-i+1)^1.3, 1];
          end
          end
     end
%      else
%         perm = [(5 / norm(position)) ^ 2, 1];
%     end
end


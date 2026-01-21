function [index] = find_nonzero_3d(data)
%[index] = find_nonzero_3d(data)
% This function is used to find the index of non-zero elements in a 3D matrix.
    Size=size(data);
    index=[];
    I=0;
    for x=1:Size(1)
        for y=1:Size(2)
            for z=1:Size(3)
                if data(x,y,z)~=0
                    I=I+1;
                    index(I,1)=x;
                    index(I,2)=y;
                    index(I,3)=z;
                end
            end
        end
    end
end

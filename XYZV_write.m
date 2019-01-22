function  XYZV_write( x,y,z,V,namefile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nx = size(x);
ny = size(y);
nz = size(z);
grdfile=fopen(namefile,'w');                % Open file
for k = 1:nz
    for i = 1:nx
        for j = 1:ny
            fprintf(grdfile,'%f %f %f %f \n',x(i),y(j),z(k),V(i,j,k));
        end
    end
end

end


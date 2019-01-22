function [ na,ma,A,Q ] = cal_GQ( d,nx,ny,nz,xmin,ymin,m,n,dx,dy,z0)
%UNTITLED 此函数用于构建核函数矩阵A
%   Detailed explanation goes here
ma = nx * ny * nz;
na = m * n;
A = zeros(na,ma);
% NSS = NSS';
% NSS = reshape(NSS,1,na);
for l = 1:m
    for s = 1:n 
        R = zeros(nx,ny,nz);
        for i = 1:nx
            for j = 1:ny
                for k = 1:nz
%                     r = (xmin + double(i - 1) * d - xmin - double(l - 1) * d )  
                      rx = double(i - 1) * d - double(l - 1) * dx;
                      rx = rx * rx;
                      ry = double(j - 1) * d - double(s - 1) * dy;
                      ry = ry * ry;
                      rz = double(k - 1) * d + 0.5 * d + z0;
                      rz = rz * rz;
                      R(i,j,k) = (rx + ry + rz) * (rx + ry + rz);
                end
            end
        end
        ka = (l-1) * n + s;
        A (ka,:) = reshape(R,ma);
    end
end

nxy = nx * ny;
q = zeros(ma,1);
for i = 1:nz
    for j = 1:nxy
        k = (i - 1) * nxy + j;
        wz = z0 + double(d - 1) * nz + 0.5 * d;
        q(k) = wz * wz * wz;
    end
end
Q = spdiags(q,0,ma,ma);
end


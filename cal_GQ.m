function [ d,mx,my,mz,na,ma,A,Q,D ] = cal_GQ( NSS,dxyz,nx,ny,nz,xm_min,ym_min,Xmin,Ymin,m,n,dx,dy,z0,delta)
%UNTITLED 此函数用于构建核函数矩阵A
%   Detailed explanation goes here
ma = nx * ny * nz;
na = m * n;
A = zeros(na,ma);
d = zeros(na,1);
r = (dxyz / 2.0);
T = 50000;
cof = T * r * r * r;
% for l = 1:m
%     for s = 1:n 
%         R = zeros(nx,ny,nz);
%         for i = 1:nx
%             for j = 1:ny
%                 for k = 1:nz
%                       rx = xm_min + double(i - 0.5) * dxyz - Xmin - double(l - 1) * dx ;  
% %                       rx = 0.5 * dx + double(i - 1) * dxyz - double(l - 1) * dx;
%                       rx = rx * rx;
%                       ry = ym_min + double(j - 0.5) * dxyz - Ymin - double(s - 1) * dy;
%                       ry = ry * ry;
%                       rz = double(k - 0.5) * dxyz  + z0;
%                       rz = rz * rz;
%                       r2 = 1.0 / (rx + ry + rz);
%                       R(i,j,k) = r2 * r2 * cof;
%                 end
%             end
%         end
%         ka = (l-1) * n + s;
%         A (ka,:) = reshape(R,1,ma);
%     end
% end
x = zeros(m,1);
for i = 1:m
    x(i) = Xmin + double(i - 1) * dx;
end
y = zeros(n,1);
for i = 1:n
    y(i) = Ymin + double(i - 1) * dy;
end
mx = zeros(nx,1);
for i = 1:nx
    mx(i) = xm_min + (i - 0.5) * dxyz;
end
my = zeros(ny,1);
for i = 1:ny
    my(i) = ym_min + (i - 0.5) * dxyz;
end
mz = zeros(nz,1);
for i = 1:nz
    mz(i) = z0 + (i - 0.5) * dxyz;
end

k2 = 0;
for l = 1:m
    for s = 1:n
        k1 = 0;
        k2 = k2 + 1;
        d(k2) = NSS(l,s);
        for k = 1:nz
            for i = 1:nx
                for j = 1:ny
                    k1 = k1 + 1;
                    rx = x(l) - mx(i);
                    rx = rx * rx;
                    ry = y(s) - my(j);
                    ry = ry * ry;
                    
                    rz = mz(k) * mz(k);
                    r2 = 1.0 / (rx + ry + rz);
                    A(k2,k1) = r2 * r2 * cof;
                end
            end
        end
    end
end

                    



nxy = nx * ny;
q = zeros(ma,1);
for i = 1:nz
    for j = 1:nxy
        k = (i - 1) * nxy + j;
        wz = (z0 + (i - 0.5) * dxyz)+0.000001;
        wz = wz * wz;
        q(k) =  wz * wz;
    end
end
Q = spdiags(q,0,ma,ma);

cov = ones(na,1);
cov = cov * ( delta * delta );
D = spdiags(cov,0,na,na);
end


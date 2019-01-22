function [ MC ] = inversion( d,na,ma,nx,ny,nz,A,Q,D,delta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
eps = 0.001 * na;
mk = ones(ma,1)*0.01;
m0 = zeros(ma,1);
dres = d - A * (mk.^2);
res = (dres' * dres) / na;
% mk = zeros(ma,1);
k = 0;
%反演迭代过程
% while (k < 10 && res > delta * delta)
while (k < 15 )
      S = spdiags(2*mk,0,ma,ma);
      SQS = S * Q * S';
      f = d - A * (mk.^2) + A * S * (mk - m0);
      [ M ] = cal_Pre_M( A,SQS,na,delta );
      [ x0 ] = pre_CG( A,SQS,D,f,M,eps );
%       SS = A * SQS * A' + D;
%       [x0] = ConjuGrad3D(SS, f, 0.0001);
      m0 = mk;
      dm = Q * S' * A' * x0;
      mk = m0 + dm;
      dres1 = d - A * (mk.^2);
      res1 = (dres1' * dres1) / na;
      while res1 >  res
            dm = dm * 0.333333;
            mk = m0 + dm;
            dres1 = d - A * (mk.^2);
            res1 = (dres1' * dres1) / na;
      end
      res = res1
      k = k + 1
end
mk2 = (mk.^2);
MC = zeros(nx,ny,nz);
k1 = 0;
for k = 1:nz
    for i = 1:nx
        for j = 1:ny
            k1 = k1 + 1;
            MC(i,j,k) = mk2(k1);
        end
    end
end

% MC = reshape(mk2,nx,ny,nz);
% x = zeros(nx,1);
% y = zeros(ny,1);
% z = zeros(nz,1);
% for i = 1:nx
%     x(i) = xm_min + double(i - 0.5) * dxyz;
% end
% for i = 1:ny
%     y(i) = ym_min + double(i - 0.5) * dxyz;
% end
% for i = 1:nz
%     z(i) = double(i - 0.5) * dxyz ;
% end
% [X,Y,Z]=meshgrid(x,y,z);





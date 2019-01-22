
clc;
clear all;
%%%%%%%%%%磁倾角和磁偏角%%%%%%%%%%
I=90/180*pi;
An=0/180*pi;
%%%%%%%%%%三个方向导数%%%%%%%%%%
L0=cos(I)*cos(An);
M0=cos(I)*sin(An);
N0=sin(I);
%%%%%%%%%%测点范围，xf为北向，yf为东向%，zf为向下%%%%%%%%%
xf=-95:10:95;
yf=-95:10:95;
zf=0;
nx=size(xf,2);
ny=size(yf,2);
nz=10;

u0=4*pi*10^(-7);
%%%%%%%%%%磁化强度%%%%%%%%%%
MA=2.0;

m=nx*ny*nz;
n=nx*ny;


% nn=5;

a=10;
b=10;
c=10;



k1=1;

  for dnx=1:nx
     for dny=1:ny
         for dnz=1:nz
             x0(k1)=-95+(dnx-1)*10; 
             y0(k1)=95-(dny-1)*10;
             z0(k1)=20+c/2+(dnz-1)*10;
               k1=k1+1;
         end
      end      
  end
  
  
  
  
  
k2=1;

  for dnx=1:nx
     for dny=1:ny
             x(k2)=-95+(dnx-1)*10; 
             y(k2)=95-(dny-1)*10;
             k2=k2+1;
      end      
  end
  
  
for k1=1:m
    for k2=1:n
     A(k1,k2)=CAL_A( x0(k1), y0(k1), z0(k1), x(k2), y(k2), zf, a, b, c, u0, L0, M0, N0)*10^9;
    end
end
A=A';


% 
%   
% for k1=1:m
%     for k2=1:n
%      A1(k1,k2)=CAL_A1( x0(k1), y0(k1), z0(k1), x(k2), y(k2), zf, a, b, c, u0, L0, M0, N0)*10^9;
%     end
% end
% A=A1';

% % 
% for k1=1:m
%     for k2=1:n
%      A2(k1,k2)=CAL_A2( x0(k1), y0(k1), z0(k1), x(k2), y(k2), zf, a, b, c, u0, L0, M0, N0)*10^9;
%     end
% end
% A=A2';



M(1:4000)=0.0001;
for mi_1=1:6
    for mi_2=1:6
        M(10*20*(mi_1-1+7)+10*(mi_2-1+7)+3:10*20*(mi_1-1+7)+10*(mi_2-1+7)+8)=MA;
    end
end
M=M';



d=A*M;

for di=1:20
 d11(di,:)=d((di-1)*20+1:di*20);
end

ma=m;
na=n;




dxyz=1;

nxy = nx * ny;



q = zeros(ma,1);
for i = 1:nz
    for j = 1:nxy
        k = (i - 1) * nxy + j;
        wz = (0 + (i - 0.5) * dxyz)+0.000001;
        wz = wz*wz;
        q(k) =  wz*wz;
    end
end
Q = spdiags(q,0,ma,ma);

delta=0.01;
cov = ones(na,1);
cov = cov * ( delta * delta );
D = spdiags(cov,0,na,na);

eps = 0.001 * n;
mk = ones(m,1)*0.001;
m0 = zeros(m,1);
dres = d - A * mk;
res = (dres' * dres) / n;
% mk = zeros(ma,1);
k = 0;
%反演迭代过程
% while (k < 10 && res > delta * delta)
while (k < 30 )
      S = spdiags(2*mk,0,ma,ma);
      SQS = S * Q * S';
      f = d - A * mk + A * S * (mk - m0);
      [ M1 ] = cal_Pre_M( A,SQS,n,delta );
      [ x0 ] = pre_CG( A,SQS,D,f,M1,eps );
%       SS = A * SQS * A' + D;
%       [x0] = ConjuGrad3D(SS, f, 0.0001);
      m0 = mk;
      dm = Q * S' * A' * x0;
      mk = m0 + dm;
      dres1 = d - A * mk;
      res1 = (dres1' * dres1) / n;
      while res1 >  res
            dm = dm * 0.333333;
            mk = m0 + dm;
            dres1 = d - A * mk;
            res1 = (dres1' * dres1) / n;
      end
      res = res1
      k = k + 1
end                 


d222=A*mk;



for di=1:20
 d2222(di,:)=d222((di-1)*20+1:di*20);
end

                 
                 
function [ NSS ] = Cal_NSS( TMI,S,U,V,m1,m2,m3,n1,n2,n3,inc,dec )
%Cal_NSS 函数用于计算NSS（正则化磁源强度）
%  TMI为总场强度矩阵 要求计算前必须扩边为2的整数幂
%  S,U,V为波数域变量.
m = m2-m1+1; %有效数据行数
n = n2-n1+1; %有效数据列数
inc = inc/180.0*pi; %地磁倾角转换
dec = dec/180.0*pi; %地磁偏角转换
L0 = cos(inc)*cos(dec); % X方向的方向余弦
M0 = cos(inc)*sin(dec); % Y方向的方向余弦
N0 = sin(inc); % Z方向的方向余弦
NSS = zeros(m,n); % NSS
FTMI = fft2(TMI);% The fourier transform of TMI
Sxx = zeros(m3,n3); 
Sxy = zeros(m3,n3);
Sxz = zeros(m3,n3);
Syy = zeros(m3,n3);
Syz = zeros(m3,n3);
for j = 1:m3
    for k = 1:n3
        if j==1 && k==1
            Sxx(j,k) = 0;
            Sxy(j,k) = 0;
            Sxz(j,k) = 0;
            Syy(j,k) = 0;
            Syz(j,k) = 0;
        else
        qt = complex(double(N0*S(j,k)),double(L0*U(j)+M0*V(k))); % 频率域转换因子
%         size(qt)
        Sxx(j,k) = -U(j)/(qt/U(j))*FTMI(j,k); % The fourier transform of Sxx
        Sxy(j,k) = -U(j)/(qt/V(k))*FTMI(j,k); % The fourier transform of Sxy
        Sxz(j,k) = complex( 0,U(j) )/(qt/S(j,k))*FTMI(j,k); % The fourier transform of Sxz
        Syy(j,k) = -V(k)/(qt/V(k))*FTMI(j,k); % The fourier transform of Syy
        Syz(j,k) = complex( 0,V(k) )/(qt/S(j,k))*FTMI(j,k); % The fourier transform of Syz
        end
    end
end
Sxx = real( ifft2(Sxx) );
Sxy = real( ifft2(Sxy) );
Sxz = real( ifft2(Sxz) );
Syy = real( ifft2(Syy) );
Syz = real( ifft2(Syz) );
for i = m1:m2
    for j = n1:n2
        MGT = [Sxx(i,j) Sxy(i,j) Sxz(i,j);
               Sxy(i,j) Syy(i,j) Syz(i,j);
               Sxz(i,j) Syz(i,j) -Sxx(i,j)-Syy(i,j)]; % 磁梯度张量矩阵 
        D = eig(MGT); % 计算矩阵特征值
        D = sort(D,'descend'); % 将特征值按照从大到小排序
        NSS(i-m1+1,j-n1+1) = sqrt(-(D(2)*D(2))-D(1)*D(3)); % 计算NSS
    end
end
end


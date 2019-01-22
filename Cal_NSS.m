function [ NSS ] = Cal_NSS( TMI,S,U,V,m1,m2,m3,n1,n2,n3,inc,dec )
%Cal_NSS �������ڼ���NSS�����򻯴�Դǿ�ȣ�
%  TMIΪ�ܳ�ǿ�Ⱦ��� Ҫ�����ǰ��������Ϊ2��������
%  S,U,VΪ���������.
m = m2-m1+1; %��Ч��������
n = n2-n1+1; %��Ч��������
inc = inc/180.0*pi; %�ش����ת��
dec = dec/180.0*pi; %�ش�ƫ��ת��
L0 = cos(inc)*cos(dec); % X����ķ�������
M0 = cos(inc)*sin(dec); % Y����ķ�������
N0 = sin(inc); % Z����ķ�������
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
        qt = complex(double(N0*S(j,k)),double(L0*U(j)+M0*V(k))); % Ƶ����ת������
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
               Sxz(i,j) Syz(i,j) -Sxx(i,j)-Syy(i,j)]; % ���ݶ��������� 
        D = eig(MGT); % �����������ֵ
        D = sort(D,'descend'); % ������ֵ���մӴ�С����
        NSS(i-m1+1,j-n1+1) = sqrt(-(D(2)*D(2))-D(1)*D(3)); % ����NSS
    end
end
end


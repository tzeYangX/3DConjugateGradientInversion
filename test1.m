function OUT = test1(S,U,V,m1,m2,m3,n1,n2,n3)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M = zeros(m3,n3);
z0 = 200;
M(33,33) = 1;
M = fft2(M);
for i = 1:m3
    for j = 1:n3
        cpx1 = (U(i)*V(j)+S(i,j)*S(i,j)/3.0);
        cpx2 = -(U(i)*U(i)*(U(i)/S(i,j))+V(j)*V(j)*(V(j)/S(i,j)))/3.0;
        cpx = complex(cpx1,cpx2);
        dpx = complex(-S(i,j),-U(i)-V(j));
%         fr = cpx*2*pi*exp(-z0*S(i,j));
%         fr = dpx*2*pi*exp(-z0*S(i,j))/S(i,j);
         fr = 2*pi*exp(-z0*S(i,j))/S(i,j);
        M(i,j) = M(i,j) * fr^0.25;
    end
end
M(1,1) = 0;
M = real(ifft2(M));
OUT = M(m1:m2,n1:n2);




end


function [S,U,V] = get_s(m3,n3,dx,dy)
%计算波数域变量s
S = zeros(m3,n3);
U = zeros(m3,1);
V = zeros(n3,1);
mp2 = (m3/2);
np2 = (n3/2);
xlength = double(m3-1)*dx;
ylength = double(n3-1)*dy;
qx = 2.0*pi/xlength;
qy = 2.0*pi/ylength;

for i = 0:m3-1
    uk = double(i);
%       uk = mp2-i;
    if i >= mp2
        uk = double(i-m3);
%         uk = double(mp2-i);
    end
    U(i+1) = uk*qx;
end

for j = 0:n3-1
    vl = double(j);
%     vl = double(np2-j);
    if j >= np2
       vl = double(j-n3);
%          vl = double(np2-j);
    end
    V(j+1) = vl*qy;
end

for i = 1:m3
    for j = 1:n3
        ss = U(i)*U(i) + V(j)*V(j);
        S(i,j) = sqrt(ss);
    end
end

end


function g = expound_2D(g,m0,m1,m2,m3,n0,n1,n2,n3)
%对数据进行2-D余弦扩边
for i = n1:n2
%     g(m0,i) = (g(m1,i)+g(m2,i))/2;
    g(m0,i) = 0;
    g(m3,i) = g(m0,i);
end

for j = n1:n2
    for i = m0+1:m1-1
        g(i,j) = g(m0,j)+cos(double(pi/2.0*(m1-i)/(m1-m0)))*(g(m1,j)-g(m0,j));
    end
    for i = m2+1:m3-1
        g(i,j) = g(m2,j)+cos(double(pi/2.0*(m3-i)/(m3-m2)))*(g(m3,j)-g(m2,j));
    end
end

for i = m0:m3
%     g(i,n0) = (g(i,n1)+g(i,n2))/2;
    g(i,n0) = 0;
    g(i,n3) = g(i,n0);
end

for i = m0:m3
    for j = n0+1:n1-1
        g(i,j) = g(i,n0)+cos(double(pi/2.0*(n1-j)/(n1-n0)))*(g(i,n1)-g(i,n0));
    end
    for j = n2+1:n3-1
        g(i,j) = g(i,n2)+cos(double(pi/2.0*(n3-j)/(n3-n2)))*(g(i,n3)-g(i,n2));
    end
end

end

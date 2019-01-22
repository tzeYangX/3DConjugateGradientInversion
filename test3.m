function test3()
A = [1 2;3 4];
S = eye(2);
Q = S;
M = S;
f = [3;4];
eps = 0.0001;
[ x0 ] = pre_CG( A,S,Q,f,M,eps )
d = (A*A')\f

end


function [ x0 ] = pre_CG( A,S,Q,f,M,eps )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
W = S * Q * S;
r0 = -f;
y0 = M * r0;
p0 = -y0;
k = 0;
x0 = zeros(size(r0));
 while k < 30  && r0' * r0 > eps
      Ap = A * ( W * (A' * p0) );
      a0 = (r0' * y0) / (p0' * Ap);
      x0 = x0 + a0 * p0;
      r1 = r0 + a0 * Ap;
      y1 = M * r1;
      b0 = (r1' * y1) / (r0' * y0);
      p0 = -y1 + b0 * p0;
      k = k + 1
      r0 = r1;
      y0 = y1;
end
end


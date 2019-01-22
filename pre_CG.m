function [ bk ] = pre_CG( A,SQS,D,f,M,eps )
%pre_CG This function is designed for solving equation system like ASQS'A'x = f,
%       where ASQS'A' is a symmetric positive definite matrix.
%       A is a m*n matrix;
%       S and Q are both n*n diagnal matrix;
%       f and x are both n dimentional column vectors;
%       M is the preconditioner, which is always a m*m sparse matrix;
%       eps is a scalar, representing rms error; 
r0 = -f;
y0 = M * r0;
p0 = -y0;
k = 0;
x0 = zeros(size(r0));
res = r0' * r0;
while ( k < 50  &&  res > eps )
      Ap = A * ( SQS * (A' * p0) ) + D * p0;
      a0 = (r0' * y0) / (p0' * Ap);
      x0 = x0 + a0 * p0;
      r1 = r0 + a0 * Ap;
      y1 = M * r1;
      b0 = (r1' * y1) / (r0' * y0);
      p0 = -y1 + b0 * p0;
      k = k + 1;
      res1 = r1' * r1;
        if (res1 < res)
           bk = x0;
           k1 = k;
        end
      r0 = r1;
      y0 = y1;
 end
end

% function test3()
% A = [1 2;3 4];
% S = eye(2);
% Q = S;
% M = S;
% f = [3;4];
% eps = 0.0001;
% [ x0 ] = pre_CG( A,S,Q,f,M,eps )
% d = (A*A')\f
% 
% end


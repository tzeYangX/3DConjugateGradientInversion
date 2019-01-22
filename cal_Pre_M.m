function [ M ] = cal_Pre_M( A,SQS,na,delta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m = zeros(na,1);
for i = 1:na
    d = A(i,:);
    m(i) =  1.0 / (d * SQS * d'+ delta * delta);
end
M = spdiags(m,0,na,na);
end



% A = rand(5000,65536);
% B = rand(50000,1);
% for i = 1:5000
% reshape(A(i,:),64,64,16);
% C = A * B;
tic;
for i = 1 : 100
    A = rand(64,64,16);
    B = wavedec3(A,7,'db4');
%     B = dwt3(A,'db4');
end
toc;

% tic;
% for i = 1 : 1000
% c = rand(1,160000);
% d = rand(160000,1);
% e = c * d;
% end 
% toc;    
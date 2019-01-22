function [dp] = ConjuGrad3D(SS, dd, delt)

r0 =  dd;
dp = zeros(size(r0));
p0 = r0;
% deltTemp=zeros(1,100);
for j = 1 : 30     %CG迭代的开始
        h = SS * p0;
        a = (r0' * r0) / (p0' * h);
        dp = dp + a * p0;
        r1 = r0 - a * h;
%         deltTemp(j)=log10(r1'*r1);
        if(r1' * r1 < delt)
            break;
        end
        
        beta = (r1' * r1) / (r0' * r0);
        r0 = r1;
        p0 = r0 + beta * p0;
end
% figure;
% plot(deltTemp);
% a=1;
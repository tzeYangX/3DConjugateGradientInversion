function [m0,m1,m2,m3,dx] = Calculate_m1m2_dx(mpoint,Xmin,Xmax)
%���������λ
m0 = 1;
dx = (Xmax-Xmin)/(mpoint-1);
mtemp = int16(mpoint);
class(mtemp)
while mod(mtemp,2)==0 && mtemp~=0 %�ж��Ƿ�Ϊ2**m
    mtemp = mtemp/2;
end
%����2**m��������һ�������ǣ������ൽ��С��2**m
if mtemp==1
   m=mpoint*2;
else
    mu=int16(fix(log(double(mpoint))/0.693147+0.05)+2);
         m=2.^mu;
end

m1 = 1+(m-mpoint)/2;
m2 = m1+mpoint-1;
m3 = m;
end


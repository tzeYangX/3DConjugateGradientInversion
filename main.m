function main()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cmdfile = 'par.txt';
% [magfile,NSS_file,inc,dec] = sub_readcmd(cmdfile); %�Ӳ����ļ��ж����ļ�������������
[magfile,NSS_file,MC_file,inc,dec,xm_min,ym_min,dxyz,nx,ny,nz,delta] = sub_readcmd(cmdfile)
[RowCols, xRng, yRng, mag_grd] = ReadSurferGrd(magfile); %�������ļ��ж����������
n = RowCols(1);%x�����ϵĵ���������������
m = RowCols(2);%y�����ϵĵ���������������
Xmin = xRng(1); % x������Сֵ
Xmax = xRng(2); % x�������ֵ
Ymin = yRng(1); % y������Сֵ
Ymax = yRng(2); % y�������ֵ
[n0,n1,n2,n3,dx] = Calculate_m1m2_dx(n,Xmin,Xmax);% x�����ϵ������ż���
[m0,m1,m2,m3,dy] = Calculate_m1m2_dx(m,Ymin,Ymax); % y�����ϵ������ż���
TMI = zeros(m3,n3);
TMI(m1:m2,n1:n2) = mag_grd; %δ������쳣ֵ
TMI = expound_2D(TMI,m0,m1,m2,m3,n0,n1,n2,n3);%�Դ��쳣���ݽ�������
[S,U,V] = get_s(m3,n3,dx,dy);%���㲨�������S,U,V
[ NSS ] = Cal_NSS( TMI,S,U,V,m1,m2,m3,n1,n2,n3,inc,dec ); %����NSS
grd_write(NSS,Xmin,Xmax,Ymin,Ymax,NSS_file); %���NSSΪGRD����
[ d,mx,my,mz,na,ma,A,Q,D ] = cal_GQ( NSS,dxyz,nx,ny,nz,xm_min,ym_min,Xmin,Ymin,m,n,dx,dy,0,delta); %����˺�������A,��ȼ�Ȩ����Q������Э�������D
[ MC ] = inversion( d,na,ma,nx,ny,nz,A,Q,D,delta );
 XYZV_write( mx,my,mz,MC,MC_file );

end


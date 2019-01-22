function main()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cmdfile = 'par.txt';
% [magfile,NSS_file,inc,dec] = sub_readcmd(cmdfile); %从参数文件中读入文件名及参数设置
[magfile,NSS_file,MC_file,inc,dec,xm_min,ym_min,dxyz,nx,ny,nz,delta] = sub_readcmd(cmdfile)
[RowCols, xRng, yRng, mag_grd] = ReadSurferGrd(magfile); %从数据文件中读入相关数据
n = RowCols(1);%x方向上的点数，即数据列数
m = RowCols(2);%y方向上的点数，即数据行数
Xmin = xRng(1); % x坐标最小值
Xmax = xRng(2); % x坐标最大值
Ymin = yRng(1); % y坐标最小值
Ymax = yRng(2); % y坐标最大值
[n0,n1,n2,n3,dx] = Calculate_m1m2_dx(n,Xmin,Xmax);% x方向上的扩编点号计算
[m0,m1,m2,m3,dy] = Calculate_m1m2_dx(m,Ymin,Ymax); % y方向上的扩编点号计算
TMI = zeros(m3,n3);
TMI(m1:m2,n1:n2) = mag_grd; %未扩编磁异常值
TMI = expound_2D(TMI,m0,m1,m2,m3,n0,n1,n2,n3);%对磁异常数据进行扩边
[S,U,V] = get_s(m3,n3,dx,dy);%计算波数域变量S,U,V
[ NSS ] = Cal_NSS( TMI,S,U,V,m1,m2,m3,n1,n2,n3,inc,dec ); %计算NSS
grd_write(NSS,Xmin,Xmax,Ymin,Ymax,NSS_file); %输出NSS为GRD数据
[ d,mx,my,mz,na,ma,A,Q,D ] = cal_GQ( NSS,dxyz,nx,ny,nz,xm_min,ym_min,Xmin,Ymin,m,n,dx,dy,0,delta); %计算核函数矩阵A,深度加权矩阵Q和噪声协方差矩阵D
[ MC ] = inversion( d,na,ma,nx,ny,nz,A,Q,D,delta );
 XYZV_write( mx,my,mz,MC,MC_file );

end


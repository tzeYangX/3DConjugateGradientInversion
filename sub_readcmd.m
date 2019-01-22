function [inputfile,outputfile1,outputfile2,inc,dec,xm_min,ym_min,dxyz,nx,ny,nz,delta] = sub_readcmd(cmdfile)
%读取输入文件名以及参数的子函数
fid = fopen(cmdfile,'r');
if -1 == fid
    errordlg('文件打开失败！！');
    return;
end
inputfile = fgetl(fid); %读取输入数据文件名
outputfile1 = fgetl(fid); %读取输出NSS数据文件名
outputfile2 = fgetl(fid); %读取输出最终物性结果
inc = str2double(fgetl(fid)); %读取地磁场倾角
dec = str2double(fgetl(fid)); %读取地磁场偏角
xm_min = str2double(fgetl(fid)); % 读取地下网格剖分xmin
ym_min = str2double(fgetl(fid)); % 读取地下网格剖分ymin
dxyz = str2double(fgetl(fid)); % 读取地下网格剖分间隔
nx = str2double(fgetl(fid)); 
ny = str2double(fgetl(fid));
nz = str2double(fgetl(fid));
delta = str2double(fgetl(fid));
fclose(fid);
end


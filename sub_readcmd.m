function [inputfile,outputfile1,outputfile2,inc,dec,xm_min,ym_min,dxyz,nx,ny,nz,delta] = sub_readcmd(cmdfile)
%��ȡ�����ļ����Լ��������Ӻ���
fid = fopen(cmdfile,'r');
if -1 == fid
    errordlg('�ļ���ʧ�ܣ���');
    return;
end
inputfile = fgetl(fid); %��ȡ���������ļ���
outputfile1 = fgetl(fid); %��ȡ���NSS�����ļ���
outputfile2 = fgetl(fid); %��ȡ����������Խ��
inc = str2double(fgetl(fid)); %��ȡ�شų����
dec = str2double(fgetl(fid)); %��ȡ�شų�ƫ��
xm_min = str2double(fgetl(fid)); % ��ȡ���������ʷ�xmin
ym_min = str2double(fgetl(fid)); % ��ȡ���������ʷ�ymin
dxyz = str2double(fgetl(fid)); % ��ȡ���������ʷּ��
nx = str2double(fgetl(fid)); 
ny = str2double(fgetl(fid));
nz = str2double(fgetl(fid));
delta = str2double(fgetl(fid));
fclose(fid);
end


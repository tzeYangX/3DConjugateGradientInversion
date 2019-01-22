function [RowCols, xRng, yRng, Dat] = ReadSurferGrd(fileName)
% rowCols=[���� ����]��xRngΪ���ᣨ������ȡֵ��Χ��yRngΪ���ᣨ������ȡֵ��Χ��DatΪ��ά����
% ֧�ֵ�Surfer Grid�ļ�����:
% 1.Surfer 6 Text Grid Format  
% 2.Surfer 6 Binary Grid File Format 
% 3.Surfer 7 Grid File Format
fid = fopen( fileName, 'r');
if -1 == fid
    errordlg('�ļ���ʧ�ܣ���');
    return;
end
headFlag = fread(fid, 1, 'int32');
switch headFlag
    case hex2dec('41415344') % Surfer 6 Text Grid Format
        [RowCols, xRng, yRng, Dat] = ReadSurferGrd_6Text(fid);
    case hex2dec('42425344') % Surfer 6 Binary Grid File Format
        [RowCols, xRng, yRng, Dat] = ReadSurferGrd_6Binary(fid);
    case hex2dec('42525344') % Surfer 7 Grid File Format
        [RowCols, xRng, yRng, Dat] = ReadSurferGrd_7(fid);
    otherwise
        errordlg('�ļ���ʽ���󣡣�');
        return;
end
fclose(fid);

function [RowCols, xRng, yRng, Dat] = ReadSurferGrd_6Text(fid)
fgetl(fid);
RowCols = str2num( fgetl(fid) );
xRng    = str2num( fgetl(fid) );
yRng    = str2num( fgetl(fid) );
fgetl(fid); %����
Dat = (fscanf(fid, '%g', RowCols))';

function [RowCols, xRng, yRng, Dat] = ReadSurferGrd_6Binary(fid)
RowCols = (fread(fid, 2, 'int16'))';
xRng = (fread(fid, 2, 'double'))';
yRng = (fread(fid, 2, 'double'))';
(fread(fid, 2, 'double'))';
Dat = fread(fid, inf, 'single');
Dat = (reshape(Dat, RowCols))';

function [RowCols, xRng, yRng, Dat] = ReadSurferGrd_7(fid)
% 1.header section
size = fread(fid, 1, 'int32');
if size ~= 4
    errordlg('�ļ���ʽ���󣡣�');
    return;
end
version = fread(fid, 1, 'int32');
if version ~= 1 && version ~= 2
    errordlg('�ļ���ʽ���󣡣�');
    return;
end
% 2.Grid section
tagId = fread(fid, 1, 'int32');
if hex2dec('44495247') ~= tagId
    errordlg('�ļ���ʽ���󣡣�');
    return;
end
fread(fid, 1, 'int32');
row = fread(fid, 1, 'int32');
cols = fread(fid, 1, 'int32');
RowCols = [cols row];
xmin = fread(fid, 1, 'double');
ymin = fread(fid, 1, 'double');
dx = fread(fid, 1, 'double');
dy = fread(fid, 1, 'double');
xmax = xmin+(cols-1)*dx;
ymax = ymin+(row-1)*dy;
xRng = [xmin xmax];
yRng = [ymin ymax];
fread(fid, 4, 'double')
% 3.Data section
tagId = fread(fid, 1, 'int32');
if hex2dec('41544144') ~= tagId
    errordlg('�ļ���ʽ���󣡣�');
    return;
end
fread(fid, 1, 'int32');
Dat = fread(fid, inf, 'double');
Dat = (reshape(Dat, RowCols))';
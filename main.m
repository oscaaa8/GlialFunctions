
doFolder = ['1012'];

% paths = getFilePaths(['RawData/' doFolder],'.czi');
paths = getFilePaths(['RawData\' doFolder],'.czi');


%%
% Number of branch points \ Total volume \ Mean branch length \ Branch Depth \ Cell body size

allProperties = [{'Filename'} {'ROI_Number'} {'Number of branch points'} {'Total Area'} {'Mean Branch Length'} ...
    {'Branch Depth'} {'Cell Body Size'}];
for p = paths'
    data = bfopen(p{1});
    data = data{1};

    z = nan([size(data{1}) length(data)]);
    for i = 1:length(data)
        z(:,:,i) = double(data{i});
    end
    
    nz = znorm(z);
    tmp = rtrace(nz,z,p{1});
    allProperties = [allProperties; tmp];
end

xlswrite(['ROI_Stats_Oscar\Mino\ROI_Stats_' doFolder],allProperties) % CHANGE THIS IF YOU WANT TO WRITE TO DIFFERENT FILE NAME

%"C:\Users\oaguil6\Desktop\ROI_Stats_Oscar\Mino\ROI_Stats_1012.xls"

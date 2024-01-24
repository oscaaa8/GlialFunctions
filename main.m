
doFolder = ['1019'];

%paths = getFilePaths(['RawData/' doFolder],'.czi');
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



basePath = '\Users\oaguil6\Sparta Lab Dropbox\Sparta Lab Team Folder\Data Analysis Microglia\Sparta_Lab\O-Plots12192023\Skeletons\';
makePath = fullfile(basePath, doFolder);
if ~exist(makePath, 'dir') % If subject skeleton folder doesnt exist -->
    if exist(paths, 'dir') % if subject file exists in raw data -->
       mkdir(makePath); % Make directory folder inside of sKELETONS
    else 
        fprintf('file does not exist in raw folder'); % or it doesnt exist and do nothing.
    end
else
    fprintf('you good G \n') % if the skeleton folder already exists print this!
end


xlswrite(['ROI_Stats_Oscar\Mino\ROI_Stats_' doFolder],allProperties) % CHANGE THIS IF YOU WANT TO WRITE TO DIFFERENT XL FILE NAME


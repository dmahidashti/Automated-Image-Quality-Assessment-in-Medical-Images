function [img, info] = ImageRead(path, imageFormat) 

% Function to read .mhd, .raw, .dcm and .png
info = []; %Assign empty array

if (imageFormat == '.mhd') 
    
    [img, info] = read_mhd(path);% Use mhd function 

elseif (imageFormat == '.raw')

    fid = fopen(path); % File identifier
    img = fscanf(fid,'%f'); % Read and convert the data from "text" to an array
    

elseif (imageFormat == '.dcm') 
    
    img = dicomread(path); % Read dicom file 
    info = dicominfo(path); % Assign header information to info

elseif (imageFormat == '.mat') 
    
    img = load(path); % Loading the file
    

elseif (imageFormat == '.png') 
    
    img = imread(path);% Simple image reading fucntion
    
elseif (imageFormat == '.pgm')
    
    img = imread(path);% Simple image reading fucntion
    
elseif (imageFormat == '.tif')
    
    img = imread(path);% Simple image reading fucntion
elseif (imageFormat == '.jpg')
    
    img = imread(path);% Simple image reading fucntion
end

end
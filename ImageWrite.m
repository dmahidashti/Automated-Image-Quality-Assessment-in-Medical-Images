function [] = ImageWrite(data, filename, type)

if (type == 'png')

imwrite(uint8(data),filename); % 8 bit unsigned integer writing for png as it only accepts unsigned integers

elseif (type == 'dcm')

dicomwrite(data,filename); % built in dicom writer fucntion

else

disp('The function is not equipped to handle the inputted format, reconsider your choices...'); 

end

end
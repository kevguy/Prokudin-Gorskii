%% CSCI 3290: Assignment 1 Starter Code

% Input glass plate image
imgname = '01087u.tif';
fullimg = imread(imgname);

% Convert to double matrix
fullimg = im2double(fullimg);

% TODO1: Extract 3 channels from input image
% Calculate the height of each part (about 1/3 of total)
ImgH = floor(size(fullimg,1)/3);

% Separate B-G-R channels
B = fullimg(1:ImgH,:);
G = fullimg(ImgH+1:ImgH*2,:);
R = fullimg(ImgH*2+1:ImgH*3,:);

%imshow(B)
%imshow(G)
%imshow(R)

% Crop images by removing 10% of each side of the image
[heightB, widthB] = size(B);
widthBToCrop = round(0.1 * widthB);
heightBToCrop = round(0.1 * heightB);
croppedB = B(heightBToCrop:heightB-heightBToCrop, widthBToCrop:widthB-widthBToCrop);
[heightG, widthG] = size(G);
widthGToCrop = round(0.1 * widthG);
heightGToCrop = round(0.1 * heightG);
croppedG = G(heightGToCrop:heightG-heightGToCrop, widthGToCrop:widthG-widthGToCrop);
[heightR, widthR] = size(R);
widthRToCrop = round(0.1 * widthR);
heightRToCrop = round(0.1 * heightR);
croppedR = R(heightRToCrop:heightR-heightRToCrop, widthRToCrop:widthR-widthRToCrop);


%% Align the images
% Functions that might be useful:"circshift", "sum", and "imresize"

tic;   % The Timer starts. To Evalute algorithms' efficiency.

% Write your codes here. 
% Write your function of alignSingle and alignMulti
if (size(croppedB, 2)<= 500)
    %disp('simple');
    aG = alignSingle(croppedG,croppedB);
    aR = alignSingle(croppedR,croppedB);
else
    %disp('complex');
     aG = alignMulti(croppedG,croppedB);
     aR = alignMulti(croppedR,croppedB);

end
%imshow(aG);

% Adjust White Balance
idealR = mean(mean(croppedB));
idealG = mean(mean(croppedB));
idealB = mean(mean(croppedB));
disp(idealB);
avgR = mean(mean(aR));
avgG = mean(mean(aG));

diffR = idealR - avgR;
diffG = idealG - avgG;

newR = aR + diffR;
newG = aG + diffG;

toc;   % The Timer stops and displays time elapsed.

%% Output Results

% Create a color image (3D array): "cat" command
% For your own code, "G","R" shoule be replaced to "aG","aR"
%colorImg = cat(3,aR,aG,croppedB);
adjImg = cat(3, newR, newG, croppedB);

% Show the resulting image: "imshow" command
%imshow(colorImg);
imshow(adjImg);


% Save result image to File
%imwrite(colorImg,['result-' imgname]);
imwrite(adjImg,['result-' imgname]);

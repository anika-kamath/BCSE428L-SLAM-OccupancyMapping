function [y,err] = DisparityMatlab2(left,right,trueground,posee)

global disparityswitch points3Dswitch ORBswitch
% a=left;
% b=right;
% left=b;
% right=a;
maxRange =30;  
persistent map3D2
if isempty(map3D2)
map3D2 = occupancyMap3D(10);
end
quaternion = angle2quat(0,0,0);
pose=[posee(2) -posee(1) -posee(3) quaternion];
if disparityswitch==1
d=0.2;   
focalLength    = [1109, 1109]; % In pixels
principalPoint = [640, 360];   % In pixels [x, y]
imageSize      = [720, 1280];  % In pixels [mrows, ncols]
baseline       = d;          % In meters

reprojectionMatrix = [1, 0, 0, -principalPoint(1); 
    0, 1, 0, -principalPoint(2);
    0, 0, 0, focalLength(1);
    0, 0, 1/baseline, 0];

intrinsics = cameraIntrinsics(focalLength,principalPoint,imageSize);


stereoParams  = stereoParameters(intrinsics, intrinsics, eye(3), [-baseline, 0 0]);
[currILeft, currIRight, r] = rectifyStereoImages(left, right, stereoParams);

frameLeftGray  = rgb2gray(currILeft);
frameRightGray = rgb2gray(currIRight);

frameLeftGray  = rgb2gray(left);
frameRightGray = rgb2gray(right);
disparityMap = disparitySGM(frameLeftGray, frameRightGray);

depth=focalLength(1)*d./disparityMap;
depth(isinf(depth)|isnan(depth)) = 100000;       %I made zero inf or NaN take care!

e=abs(trueground-depth);

RGB2e =im2uint8(e / 350); %this value corta OJO
cmap = gray(60);            %this value corta OJO
Je = ind2gray(RGB2e,cmap);
rgbImagee = ind2rgb(Je, flipud(cmap));
% imshow(rgbImagee)

RGB2 =im2uint8(depth / 255); %this value corta OJO
cmap = hot(150);            %this 150 corta OJO

J = ind2gray(RGB2,cmap);
rgbImage = ind2rgb(J, cmap);





if points3Dswitch==1
points3D = reconstructScene(disparityMap, reprojectionMatrix);

ind = (-maxRange < points3D(:,:,1) & points3D(:,:,1) < maxRange ...
        & -maxRange  < points3D(:,:,2) & points3D(:,:,2) < maxRange ...
         & -maxRange  < points3D(:,:,3) & points3D(:,:,3) < maxRange);
    
    points3D = points3D.*ind;

pcl = pointCloud(points3D);

pcl_wogrd_sampled = pcdownsample(pcl,'random',0.3);

ptCloudOut = pcdenoise(pcl_wogrd_sampled,'NumNeighbors',8,'Threshold',0.00001);

points=ptCloudOut.Location;

 points(any(isnan(points), 2), :) = [];

points = [points(:,1) -points(:,3) -points(:,2)];
insertPointCloud(map3D2,pose,points,maxRange);

h=show(map3D2);
% view(175,75);
axis equal

end

%% Overlay depth and rgb

err=im2uint8(rgbImagee);
y=im2uint8(rgbImage);
else
err = uint8(ones(720,1280,3));
y = uint8(ones(720,1280,3));
end
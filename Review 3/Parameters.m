clear all
close all
clc

d=0.2;       %meters between left and right camera
global disparityswitch points3Dswitch ORBswitch 
disparityswitch=1;
points3Dswitch=1;
ORBswitch=0;

% Camera Calibrator App and Export Camera Parameters
focalLength    = [1109, 1109]; % In pixels
principalPoint = [640, 360];   % In pixels [x, y]
imageSize      = [720, 1280];  % In pixels [mrows, ncols]
baseline       = d;          % In meters

reprojectionMatrix = [1, 0, 0, -principalPoint(1); 
    0, 1, 0, -principalPoint(2);
    0, 0, 0, focalLength(1);
    0, 0, 1/baseline, 0];


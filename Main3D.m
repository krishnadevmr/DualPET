%% System Matrix Calculator for a 2 detector PET system
% Authors: Dimitrios & Krishnadev
% Date: 15-06-2017
% Version: 1.0
% Accepts input about number of crystals in the detector and desired voxel grid

clc;
clear all;
close all;
tic;
%% Crystal Details---------------------------------------------------------
NumberOfCrystalsInLine=25; % Number of crystals in a given direction
CrystalWidth=1; % Crystal width in mm
DetectorPlanes=[0 0 1 0 ; 0 0 1 50]; %Denotes the 1st detector is in the z plane and the 2nd is parallel to the first at a distance of 50
DistanceBetweenDetectors=abs(DetectorPlanes(1,4)-DetectorPlanes(2,4)); %Distance between detectors
CrystalDetails=[DistanceBetweenDetectors,NumberOfCrystalsInLine,CrystalWidth];

%% Voxel Details-----------------------------------------------------------
VoxelGridStartPosZ=12.5;
VoxelGridStartPosY=3;
VoxelGridStartPosX=7;
VoxelWidth=1;
NumofVoxelsXYZ=[20 20 20];

VoxelDetails=[VoxelGridStartPosZ,VoxelWidth,NumofVoxelsXYZ,VoxelGridStartPosX,VoxelGridStartPosY];

%% Create crystal coordinates & centers
[ CoordinatesDetector1] = GetCrystalCoordinates( DetectorPlanes(1,:),CrystalDetails );
[ CoordinatesDetector2] = GetCrystalCoordinates( DetectorPlanes(2,:),CrystalDetails );

%% Create Voxel Planes
 [VoxelPlanesX,VoxelPlanesY,VoxelPlanesZ] = GetG5(VoxelDetails);
 
%% Get intercection with Voxel Planes
%[ AllIntercepts ] = GetAllIntercepts(CoordinatesDetector1, CoordinatesDetector2,VoxelPlanesX,VoxelPlanesY,VoxelPlanesZ,CrystalDetails,VoxelDetails);
[ AllIntercepts,AllInterceptsVoxelID ] = GetAllInterceptsWithVoxeldID( CoordinatesDetector1,CoordinatesDetector2,VoxelPlanesX,VoxelPlanesY,VoxelPlanesZ,CrystalDetails,VoxelDetails );
%% System matrix
%[ SystemMatrix ] = CalculateSystemMatrix( AllIntercepts,VoxelDetails );
[ SystemMatrix ] = SystemMatrixbyLOR( AllIntercepts,VoxelDetails, AllInterceptsVoxelID );
SystemMatrixNormalised=SystemMatrix/max(max(max(SystemMatrix)));
toc;
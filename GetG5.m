function [ x,y,z  ] = GetG5(VoxelDetails)
% This function oututs the planes which form the complete grid of voxels
% Voxel charateristics
% VoxelDetails=[VoxelGridStartPos,VoxelWidth,NumofVoxelsXYZ];
nz=VoxelDetails(5);
nx=VoxelDetails(3);
ny=VoxelDetails(4);
VoxelWidth=VoxelDetails(2);

PositionMarker=0;

%% Define z planes
for i=1:nz+1
    z(i,:)=[0 0 1 VoxelDetails(1)+PositionMarker];
    PositionMarker=PositionMarker+VoxelWidth;
end

%% Define y planes
PositionMarker=0;
for i=1:ny+1
    y(i,:)=[0 1 0 VoxelDetails(7)+PositionMarker];
    PositionMarker=PositionMarker+VoxelWidth;
end

%% Define x planes
PositionMarker=0;
for i=1:nx+1
    x(i,:)=[1 0 0 VoxelDetails(6)+PositionMarker];
    PositionMarker=PositionMarker+VoxelWidth;
end

end
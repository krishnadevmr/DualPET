function [ Coordinates ] = GetCrystalCoordinates( CrystalPlane,CrystalDetails )
% This function outputs the coordinatees of the center of each crystal in a
% given detector
% 
%CrystalDetails=[DistanceBetweenDetectors,NumberOfCrystalinLine,CrystalWidth];

a=CrystalPlane(1);
b=CrystalPlane(2);
c=CrystalPlane(3);
d=CrystalPlane(4);
Coordinates=cell(CrystalDetails(2),CrystalDetails(2));

for i=1:CrystalDetails(2)
    for j=1:CrystalDetails(2)
        x=(i-1)*CrystalDetails(3)+CrystalDetails(3)/2;
        y=(j-1)*CrystalDetails(3)+CrystalDetails(3)/2;
        z=d;
        Coordinates{i,j}=[x y z];
    end
end



end


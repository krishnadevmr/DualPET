function [ AllIntercepts ] = GetAllIntercepts(CoordinatesCrystal1,CoordinatesCrystal2,VoxelPlanesX,VoxelPlanesY,VoxelPlanesZ,CrystalDetails,VoxelDetails)
% This function outputs the intercepts each LOR makes with the voxel grid.
% fix positions for filtering
% VoxelDetails=[VoxelGridStartPos,VoxelWidth,NumofVoxelsXYZ];
zlim=[VoxelDetails(1),VoxelDetails(1)+VoxelDetails(2)*VoxelDetails(5)];
ylim=[VoxelDetails(7),VoxelDetails(7)+VoxelDetails(2)*VoxelDetails(4)];
xlim=[VoxelDetails(6),VoxelDetails(6)+VoxelDetails(2)*VoxelDetails(3)];

AllIntercepts=cell(CrystalDetails(2));
for i=1:CrystalDetails(2)
    for j=1:CrystalDetails(2)
        AllIntercepts{i,j}=cell(CrystalDetails(2));
        
        xyz=CoordinatesCrystal1{i,j};
        xyzcell=num2cell(xyz);
        [x1 y1 z1]=xyzcell{:};
             
        for l=1:CrystalDetails(2)
            for m=1:CrystalDetails(2)
                xyz=CoordinatesCrystal2{l,m};
                xyzcell=num2cell(xyz);
                [x2 y2 z2]=xyzcell{:};
              
               LORcounter=0;
               % For z planes
               for k=1:size(VoxelPlanesZ,1)
                   plane=VoxelPlanesZ(k,:);
                   InterceptionPoint = GetIntercectionWIthPlane(plane,[x1 y1 z1],[x2 y2 z2]);
                   if isfinite(InterceptionPoint(1)) && isfinite(InterceptionPoint(2)) &&isfinite(InterceptionPoint(3)) &&...
                      InterceptionPoint(1)>=xlim(1) && InterceptionPoint(1)<=xlim(2) &&...
                      InterceptionPoint(2)>=ylim(1) && InterceptionPoint(2)<=ylim(2) &&...
                      InterceptionPoint(3)>=zlim(1) && InterceptionPoint(3)<=zlim(2)
                  
                      LORcounter=LORcounter+1;
                      InterceptsSingleLOR(LORcounter,:)=InterceptionPoint;
                   end
               end
               % For x planes
               for k=1:size(VoxelPlanesX,1)
                   plane=VoxelPlanesX(k,:);
                   InterceptionPoint = GetIntercectionWIthPlane(plane,[x1 y1 z1],[x2 y2 z2]);
                   if isfinite(InterceptionPoint(1)) && isfinite(InterceptionPoint(2)) &&isfinite(InterceptionPoint(3)) &&...
                      InterceptionPoint(1)>=xlim(1) && InterceptionPoint(1)<=xlim(2) &&...
                      InterceptionPoint(2)>=ylim(1) && InterceptionPoint(2)<=ylim(2) &&...
                      InterceptionPoint(3)>=zlim(1) && InterceptionPoint(3)<=zlim(2)
                  
                      LORcounter=LORcounter+1;
                      InterceptsSingleLOR(LORcounter,:)=InterceptionPoint;
                   end
               end
               
               % For y planes
               for k=1:size(VoxelPlanesY,1)
                   plane=VoxelPlanesY(k,:);
                   InterceptionPoint = GetIntercectionWIthPlane(plane,[x1 y1 z1],[x2 y2 z2]);
                   if isfinite(InterceptionPoint(1)) && isfinite(InterceptionPoint(2)) &&isfinite(InterceptionPoint(3)) &&...
                      InterceptionPoint(1)>=xlim(1) && InterceptionPoint(1)<=xlim(2) &&...
                      InterceptionPoint(2)>=ylim(1) && InterceptionPoint(2)<=ylim(2) &&...
                      InterceptionPoint(3)>=zlim(1) && InterceptionPoint(3)<=zlim(2)
                  
                      LORcounter=LORcounter+1;
                      InterceptsSingleLOR(LORcounter,:)=InterceptionPoint;
                   end
               end
               
            if LORcounter > 1 && size(unique(InterceptsSingleLOR,'rows'),1)>1
            AllIntercepts{i,j}{l,m}=unique(InterceptsSingleLOR,'rows');
            else
            AllIntercepts{i,j}{l,m}=0;  
            end
            clear InterceptsSingleLOR;
            end
        end
        
    end
end



end


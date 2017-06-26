function [ SystemMatrix ] = SystemMatrixbyLOR( AllIntercepts,VoxelDetails, AllInterceptsVoxelID )

SystemMatrix=zeros(VoxelDetails(3),VoxelDetails(4),VoxelDetails(5));

for l=1:size(AllIntercepts,1)
    for m=1:size(AllIntercepts,1)
        for n=1:size(AllIntercepts,1)
            for o=1:size(AllIntercepts,1)
                if AllIntercepts{l,m}{n,o}~=0

                [~,maxIndex]=max(AllIntercepts{l,m}{n,o}(:,3));
                [~,minIndex]=min(AllIntercepts{l,m}{n,o}(:,3));
                            
      
                xmax=AllIntercepts{l,m}{n,o}(maxIndex,1);
                ymax=AllIntercepts{l,m}{n,o}(maxIndex,2);
                zmax=AllIntercepts{l,m}{n,o}(maxIndex,3);
                            
                xmin=AllIntercepts{l,m}{n,o}(minIndex,1);
                ymin=AllIntercepts{l,m}{n,o}(minIndex,2);
                zmin=AllIntercepts{l,m}{n,o}(minIndex,3);
                [tmp1,~]=size(AllIntercepts{l,m}{n,o});
                            
                TotalDistance= sqrt((xmax-xmin)^2+(ymax-ymin)^2+(zmax-zmin)^2);
                if TotalDistance>0
                for i=1:size(AllInterceptsVoxelID{l,m}{n,o},1)
                    % For voxel defined by first row
                    voxel=AllInterceptsVoxelID{l,m}{n,o}(i,:);
                    xhigh=voxel(1)*VoxelDetails(2)+VoxelDetails(6);
                    xlow=xhigh-VoxelDetails(2);
                    yhigh=voxel(2)*VoxelDetails(2)+VoxelDetails(7);
                    ylow=yhigh-VoxelDetails(2);
                    zhigh=voxel(3)*VoxelDetails(2)+VoxelDetails(1);
                    zlow=zhigh-VoxelDetails(2);
                    
                    counter=0;
                    for p=1:tmp1
                        x = AllIntercepts{l,m}{n,o}(p,1);
                        y = AllIntercepts{l,m}{n,o}(p,2);
                        z = AllIntercepts{l,m}{n,o}(p,3);
                                
                        if x>=xlow && x<=xhigh && y>=ylow && y<=yhigh && z>=zlow && z<=zhigh
                             counter=counter+1;
                             VI(counter,:)=[x,y,z];% voxel intercept
                        end
                     end
                            
                      if counter==2
                          DistanceInVoxel=sqrt((VI(1,1)-VI(2,1))^2 +(VI(1,2)-VI(2,2))^2 +(VI(1,3)-VI(2,3))^2 );
                      else
                          DistanceInVoxel=0;
                      end

                      voxelcontribution=DistanceInVoxel/TotalDistance;
                      SystemMatrix(voxel(1),voxel(2),voxel(3))=SystemMatrix(voxel(1),voxel(2),voxel(3))+voxelcontribution;
                end
                end
               end
            end
        end
    end
end


end


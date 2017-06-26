function [ SystemMatrix ] = CalculateSystemMatrix( AllIntercepts,VoxelDetails )
SystemMatrix=zeros(VoxelDetails(3),VoxelDetails(4),VoxelDetails(5));


for i=1:VoxelDetails(3)
    for j=1:VoxelDetails(4)
        for k=1:VoxelDetails(5)
            VoxelContribution=0;
%             VoxelXlim=[(i-1)*VoxelDetails(2),i*VoxelDetails(2)];
%             VoxelYlim=[(j-1)*VoxelDetails(2),j*VoxelDetails(2)];
            VoxelXlim=[VoxelDetails(6)+(i-1)*VoxelDetails(2),VoxelDetails(6)+i*VoxelDetails(2)];
            VoxelYlim=[VoxelDetails(7)+(j-1)*VoxelDetails(2),VoxelDetails(7)+j*VoxelDetails(2)];
            VoxelZlim=[VoxelDetails(1)+(k-1)*VoxelDetails(2),VoxelDetails(1)+ k*VoxelDetails(2)];
            
            for l=1:size(AllIntercepts,1)
                for m=1:size(AllIntercepts,1)
                    for n=1:size(AllIntercepts,1)
                        for o=1:size(AllIntercepts,1)
                            
                            [tmp1,~]=size(AllIntercepts{l,m}{n,o});
                            if AllIntercepts{l,m}{n,o}~=0
                            [~,maxIndex]=max(AllIntercepts{l,m}{n,o}(:,3));
                            [~,minIndex]=min(AllIntercepts{l,m}{n,o}(:,3));
                            
      
                            xmax=AllIntercepts{l,m}{n,o}(maxIndex,1);
                            ymax=AllIntercepts{l,m}{n,o}(maxIndex,2);
                            zmax=AllIntercepts{l,m}{n,o}(maxIndex,3);
                            
                            xmin=AllIntercepts{l,m}{n,o}(minIndex,1);
                            ymin=AllIntercepts{l,m}{n,o}(minIndex,2);
                            zmin=AllIntercepts{l,m}{n,o}(minIndex,3);
                            
                            TotalDistance= sqrt((xmax-xmin)^2+(ymax-ymin)^2+(zmax-zmin)^2);
                            counter=0;
                            for p=1:tmp1
                                x = AllIntercepts{l,m}{n,o}(p,1);
                                y = AllIntercepts{l,m}{n,o}(p,2);
                                z = AllIntercepts{l,m}{n,o}(p,3);
                                
                                if x>=VoxelXlim(1) && x<=VoxelXlim(2) && y>=VoxelYlim(1) && y<=VoxelYlim(2) && z>=VoxelZlim(1) && z<=VoxelZlim(2)
                                   counter=counter+1;
                                   VI(counter,:)=[x,y,z];% voxel intercept
                                end
                            end
                                                            
                                if counter==2
                                   DistanceInVoxel=sqrt((VI(1,1)-VI(2,1))^2 +(VI(1,2)-VI(2,2))^2 +(VI(1,3)-VI(2,3))^2 );
                                else
                                   DistanceInVoxel=0;
                                end
                                VoxelContribution=VoxelContribution+DistanceInVoxel/TotalDistance;
                            end
                        end
                    end
                end
            end

            SystemMatrix(i,j,k)=VoxelContribution;
            
        end
    end
end



end


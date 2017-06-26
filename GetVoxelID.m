function [ VoxelIndex ] = GetVoxelID( UniqueSingleLOR,VoxelDetails )

     [maxX]=max(UniqueSingleLOR(:,1));
     [minX]=min(UniqueSingleLOR(:,1));
     Xstart=modCeil((minX-VoxelDetails(6))/VoxelDetails(2));
     Xend=ceil((maxX-VoxelDetails(6))/VoxelDetails(2));
                    
     [maxY]=max(UniqueSingleLOR(:,2));
     [minY]=min(UniqueSingleLOR(:,2));
     Ystart=modCeil((minY-VoxelDetails(7))/VoxelDetails(2));
     Yend=ceil((maxY-VoxelDetails(7))/VoxelDetails(2));
                    
     [maxZ]=max(UniqueSingleLOR(:,3));
     [minZ]=min(UniqueSingleLOR(:,3));
     Zstart=modCeil((minZ-VoxelDetails(1))/VoxelDetails(2));
     Zend=ceil((maxZ-VoxelDetails(1))/VoxelDetails(2));
                
                
                vcounter=0;
                for a=Xend:-1:Xstart
                    for b=Yend:-1:Ystart
                        for c=Zend:-1:Zstart
                            vcounter=vcounter+1;
                            VoxelIndex(vcounter,:)=[a b c];
                        end
                    end                  
                end


end


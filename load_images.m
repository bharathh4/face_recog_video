function [I,labels]=load_images(folder_train_images)

    I={};
    labels=[];
    k=1;
    for j=1:6
    
        % s1\raw
        folder=sprintf('s%d\\raw\\',j);
        f=fullfile(folder_train_images,folder);
        image_files=dir(sprintf('%s*jpg',f));

        nfiles = length(image_files);    % Number of files found in speaker folder

        for i=1:nfiles
            currentfilename = image_files(i).name;
%             sprintf('%s%s',f,currentfilename);
%             s1\raw\1.jpg
            currentimage = imread(sprintf('%s%s',f,currentfilename));
            % if rgb use 
            I{k} = rgb2gray(currentimage);
            %I{k}=currentimage;
            k=k+1;
%             I{i} = (currentimage);
%             figure
%             imshow(I{i})
            labels=[labels ; j];
        end

    end
  
%     display('The size of I')
%     size(I)
end
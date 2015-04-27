function [features,claimed_labels]=get_testdata_features(folder_test_images,eigenvectors_traindata,meanvector,frame_needed)

% returns images
[images,claimed_labels]=load_images(folder_test_images);

%creates horizontal vectors for each image with resize dimensiosn specified
images_vector=vectorize_images(images,frame_needed);


for i=1:size(images_vector,1)
images_vector(i,:)=images_vector(i,:)-meanvector;
end


display('The size of image eig vector is')
size(images_vector)
size(eigenvectors_traindata)


% project test data on eigenvectors
  CNew1=[];
  M=size(images_vector,1);
for h=1:M
    temp=[];
    
    for i=1:size(eigenvectors_traindata,2) %the number of eigen-vectors
        temp=[temp dot(eigenvectors_traindata(:,i),images_vector(h,:))];
    end
    
    CNew1=[CNew1;temp];
    
end 

    size(CNew1)
    features=CNew1;

end
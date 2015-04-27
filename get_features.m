function [y,labels,eigenvectors,mean_vector]=get_features(folder_train_images,frame_needed,num_dim_to_project_onto)

%Bugs If images are same .. no eigen vectors and it throws a error
%Bugs If images are of different size we get error 

% returns images
[images,labels]=load_images(folder_train_images);

%creates horizontal vectors for each image with resize dimensiosn specified
images_vector=vectorize_images(images,frame_needed);

% reduces dimensions
  
  [y,eigenvectors,mean_vector]=reduce_dim(images_vector,num_dim_to_project_onto);

end
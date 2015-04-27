clc
clear all
close all




frame_needed=[108 192]*2;
num_dim_to_project_onto=20;
folder_train_images='C:\Users\TheatroIT\Documents\MSP\Matlab\Face recognizerVideo\train';
[train_data_features,labels_train,eigenvectors_traindata,mean_vector]=get_features(folder_train_images,frame_needed,num_dim_to_project_onto);
% imshow(f{1})
save('features_labels_eig_mean.mat','train_data_features','labels_train','eigenvectors_traindata','mean_vector')


folder_test_images='C:\Users\TheatroIT\Documents\MSP\Matlab\Face recognizerVideo\test';
[test_data_features,claimed_labels]=get_testdata_features(folder_test_images,eigenvectors_traindata,mean_vector,frame_needed);

display('The size of test data features is')
size(test_data_features)

predicted_label=[];

for j=1:size(test_data_features,1)
    
    w=[];
    for i=1:size(train_data_features,1)
        
        w= [w norm(test_data_features(j,:)-train_data_features(i,:))];
        
    end
    
    [val,index]=min(w);
    predicted_label=[predicted_label ; labels_train(index)];
    
end
claimed_labels
predicted_label


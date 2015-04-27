function image_vectors=vectorize_images(images,frame_needed)

temp_vector=[];
for i=1:length(images)
    
    
    resized_frame=imresize(images{i},frame_needed);
    vector_image=reshape(resized_frame,1,frame_needed(1)*frame_needed(2));
    temp_vector=[temp_vector ; vector_image];
end

image_vectors=double(temp_vector);

end
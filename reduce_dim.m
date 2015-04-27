function [y,eigenvectors,mean_vector]=reduce_dim(images_vector,num_dim_to_project_onto)

C1=images_vector;
% Find mean of the training samples
mean_vector=mean(C1);

%Normalise the training samples by subrating the mean
M=size(C1,1);
for i=1:M
    temp=C1(i,:)-mean_vector;
    C1(i,:)=temp;
end

% We do this because cov(C1) is very expensive 
L=C1*C1';
% Find eigen values
[vv dd]=eig(L);
% Sort and eliminate those whose eigenvalue is zero
v=[];
d=[];

for i=1:size(vv,2)
    if(dd(i,i)>1e-4)
        v=[v vv(:,i)];
        d=[d dd(i,i)];
    end
end

 %sort,  will return an ascending sequence
 [B index]=sort(d);
 ind=zeros(size(index));
 dtemp=zeros(size(index));
 vtemp=zeros(size(v));
 len=length(index);
 for i=1:len
    dtemp(i)=B(len+1-i);
    ind(i)=len+1-index(i);
    vtemp(:,ind(i))=v(:,i);
 end
 d=dtemp;
 v=vtemp;

% 
% %Normalization of eigenvectors
 for i=1:size(v,2)       %access each column
   kk=v(:,i);
   temp=sqrt(sum(kk.^2));
   v(:,i)=v(:,i)./temp;
 end

% Here u will contain as column vectors the eigen vectors
%Eigenvectors of C matrix
u=[];
for i=1:size(v,2)
    temp=sqrt(d(i));
    u=[u (C1'*v(:,i))./temp];
end

%Normalization of eigenvectors
for i=1:size(u,2)
   kk=u(:,i);
   temp=sqrt(sum(kk.^2));
	u(:,i)=u(:,i)./temp;
end

% %plot images
% for i=1:size(u,2)
%     img=reshape(u(:,i),400,40); % this must correspond to the vector size that I artificially created
%     img=img';
%     img=histeq(img,255);
%     subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
%     imshow(img)
%     drawnow;
%     if i==3
%         title('Eigenfaces','fontsize',18)
%     end
% end
 
% Project into lower dimensions by taking dot product with eigen-vectors
CNew1=[];
for h=1:M
    temp=[];
    
    if(size(u,2)<num_dim_to_project_onto)
        display('Hey I dont think the dataset varies enough to have so many eigenvectors.Try reducing the num of dim to reduce one less than unique images')
    end
    
    for i=1:num_dim_to_project_onto %the number of eigen-vectors
        temp=[temp dot(u(:,i),C1(h,:))];
    end
    
    CNew1=[CNew1;temp];
    
end

%Reduced dimesions data with reduced feature set
y=CNew1;
eigenvectors=u(:,1:num_dim_to_project_onto);
display('reduce_dim---The size of eigenvectors  is');
 size(eigenvectors)
 display('The size of u is');
 size(u)
 
end
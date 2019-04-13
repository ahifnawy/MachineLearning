function [best_centroids,best_cluster,best_error] = K_means(X,K )
% best_error=inf;
% best_centroids=zeros(K,size(X,2));
% best_cluster=zeros(size(X,1), 1);
% for c=1:10
%initalize centroids
shuffle_data=randperm(size(X, 1));
centroids = X(shuffle_data(1:K), :);

cluster=zeros(size(X,1), 1);
m=size(X,1);
cond=1;
past_cluster=zeros(size(X,1), 1);
counter=0;
while cond==1
    for i=1:m
        best_distance=Inf;
        d=X(i,:);
        for j=1:K
            current=centroids(j,:);
            distance=sum((d-current).^2);
            if distance<best_distance
                best_distance= distance;
                cluster(i,1)=j;
            end
            
        end
    end
    error=0;
    for i = 1:K
        centroids(i, :) = mean(X(cluster == i, :));
       error=error+1/m*sum(sum((X(cluster==i,:)-centroids(i,:)).^2));
    end
%     if error<best_error
%         best_error=error
%         best_centroids=centroids
%         best_cluster=cluster
%     end
    if past_cluster==cluster
        cond=0;
    end
    past_cluster=cluster;
    counter=counter+1
end
best_error=error
best_centroids=centroids
best_cluster=cluster
end
% end

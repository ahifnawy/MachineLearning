clc
clear all
ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
X=T{1:17999,4:21};
m=length(T{:,1});
X_normal= X-mean(X)./std(X); % feature normalization 
price=T{1:17999,3};
price=price-mean(price)./std(price)

[Z K error error_percentage]= PCA(X_normal)
E=LinearReg(.001,Z,price)
figure(1)
plot(E)
[centroid cluster c_error]=K_means(X,3)
c_error=zeros(1,10);

for i=1:10
    [centroid cluster c_error(i)]=K_means(X,i)
end
figure(1)
plot(1:10,c_error)
c_errorZ=zeros(1,10)
for i=1:10
    [centroidZ clusterZ c_errorZ(i)]=K_means(Z,i)
end
figure(2)
plot(1:10,c_errorZ)
anomaly=AnomalyDetect(X)
find(anomaly==1)
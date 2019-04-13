function [anomaly ] = AnomalyDetect( X )
mu=mean(X);
sigma=cov(X);
f=mvnpdf(X,mu,sigma)
anomaly(find(f<1e-100))=1
end


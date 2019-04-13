function [Z, K, error, error_percentage] = PCA( X )
m=length(X(:,1))
Corr_x = corr(X);
x_cov=cov(X); 
[U S V] =  svd(x_cov);

K=0
diagonal_S=trace(S); 
alpha=1;
 while alpha>0.001 
   K=K+1
   S_K=S(1:K,1:K);
   alpha=1-trace(S_K)/diagonal_S
 end
U_reduced=U(:,1:K);
Z=X*U_reduced;
X_approx=Z*U_reduced';
error= 1/m*sumsqr(X-X_approx)
error_percentage=error/sumsqr(X)


end


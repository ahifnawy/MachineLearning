clc 
clear all
ds = tabularTextDatastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
Alpha=.0001;
U=T{:,1:14};
features= U(:,1:13);
target=U(:,14);
m=150
age=U(1:m,1);
age=age/mean(age);
trest=U(1:m,4)
trest=trest/mean(trest)
chol=U(1:m,5);
chol=chol/mean(chol);

Z=[age trest chol];
X1=[ones(m,1) Z];
X2=[ones(m,1) Z Z.^(2)];
X3=[ones(m,1) Z Z.^(2) Z.^(3)];
X4=[ones(m,1) Z Z.^(2) Z.^(3) Z.^(4)];
Y1=target(1:m,:);

n1=length(X1(1,:));

Theta1=zeros(n1,1);
k1=1;
R=1;
h1=1./(1+ exp(-X1*Theta1));
E1(k1)=-(1/m)*sum (Y1.*log(h1)+(1-Y1).*log(1-h1));

for i=1:50000
h1=1./(1+ exp(-X1*Theta1));
Theta1=Theta1-(Alpha/m)*transpose(X1)*(h1-Y1);
k1=k1+1
E1(k1)=-(1/m)*sum (Y1.*log(h1)+(1-Y1).*log(1-h1));
% if E1(k1-1)-E1(k1)<0
%     break
% end 
% q=(E1(k1-1)-E1(k1))./E1(k1-1);
% if q <.000001;
%     R=0;
% end
end
figure (1)
plot(E1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
n2=length(X2(1,:));

Theta2=zeros(n2,1);
k2=1;
R=1;
h2=1./(1+ exp(-X2*Theta2));
E2(k2)=-(1/m)*sum (Y1.*log(h2)+(1-Y1).*log(1-h2));

for i=1:50000
h2=1./(1+ exp(-X2*Theta2));
Theta2=Theta2-(Alpha/m)*transpose(X2)*(h2-Y1);
k2=k2+1
E2(k2)=-(1/m)*sum (Y1.*log(h2)+(1-Y1).*log(1-h2));
% if E1(k1-1)-E1(k1)<0
%     break
% end 
% q=(E1(k1-1)-E1(k1))./E1(k1-1);
% if q <.000001;
%     R=0;
% end
end
figure (2)
plot(E2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%
n3=length(X3(1,:));

Theta3=zeros(n3,1);
k3=1;
R=1;
h3=1./(1+ exp(-X3*Theta3));
E3(k3)=-(1/m)*sum (Y1.*log(h3)+(1-Y1).*log(1-h3));

for i=1:50000
h3=1./(1+ exp(-X3*Theta3));
Theta3=Theta3-(Alpha/m)*transpose(X3)*(h3-Y1);
k3=k3+1
E3(k3)=-(1/m)*sum (Y1.*log(h3)+(1-Y1).*log(1-h3));
% if E1(k1-1)-E1(k1)<0
%     break
% end 
% q=(E1(k1-1)-E1(k1))./E1(k1-1);
% if q <.000001;
%     R=0;
% end
end
figure (3)
plot(E3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%
n4=length(X4(1,:));

Theta4=zeros(n4,1);
k4=1;
R=1;
h4=1./(1+ exp(-X4*Theta4));
E4(k4)=-(1/m)*sum (Y1.*log(h4)+(1-Y1).*log(1-h4));

for i=1:50000
h4=1./(1+ exp(-X4*Theta4));
Theta4=Theta4-(Alpha/m)*transpose(X4)*(h4-Y1);
k4=k4+1
E4(k4)=-(1/m)*sum (Y1.*log(h4)+(1-Y1).*log(1-h4));
% if E1(k1-1)-E1(k1)<0
%     break
% end 
% q=(E1(k1-1)-E1(k1))./E1(k1-1);
% if q <.000001;
%     R=0;
% end
end
figure (4)
plot(E4)



age_val=U(151:250,1);
age_val=age_val/mean(age_val);

trest_val=U(151:250,4);
trest_val=trest_val/mean(trest_val);

chol_val=U(151:250,5);
chol_val=chol_val/mean(chol_val);

target_val=target(151:250,1);

Z_val=[age_val trest_val chol_val];

X1_val=[ones(100,1) Z_val];
X2_val=[ones(100,1) Z_val Z_val.^(2)];
X3_val=[ones(100,1) Z_val Z_val.^(2) Z_val.^(3)];
X4_val=[ones(100,1) Z_val Z_val.^(2) Z_val.^(3) Z_val.^(4)];
h_val=1./(1+ exp(-X1_val*Theta1));
E1_val=-(1/100)*sum (target_val.*log(h_val)+(1-target_val).*log(1-h_val))

h2_val=1./(1+ exp(-X2_val*Theta2));
E2_val=-(1/100)*sum (target_val.*log(h2_val)+(1-target_val).*log(1-h2_val))

h3_val=1./(1+ exp(-X3_val*Theta3));
E3_val=-(1/100)*sum (target_val.*log(h3_val)+(1-target_val).*log(1-h3_val))

h4_val=1./(1+ exp(-X4_val*Theta4));
E4_val=-(1/100)*sum (target_val.*log(h4_val)+(1-target_val).*log(1-h4_val))




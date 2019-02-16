clear all
ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
Alpha=.0001;
;
%m=length(T{:,1});
m=11000
U0=T{:,2}
U=T{:,4:19};

price=T{1:11000,3};
price=price/mean(price);

bed=U(1:11000,1);
bed=bed/mean(bed);

bath=U(1:11000,2);
bath=bath/max(bath);

%living=U(1:11000,3)
%living=(living-mean(living))/std(living)
%floor=U(1:11000,5)

condition=U(1:11000,8);
condition=condition/max(condition);

year=(U(1:11000,12)-min(U(1:11000,12)));
year=year/max(year);

Z=[bed bath condition year];
X1=[ones(m,1) Z];

X2=[ones(m,1) Z Z.^(2) Z.^(3) Z.^(4) Z.^(5)];

X3=[ones(m,1) Z Z.^(2) Z.^(3) exp(Z)];

X4=[ones(m,1) Z Z.^(2) Z.^(3) Z.^(4) exp(-Z)];





n1=length(X1(1,:));
n2=length(X2(1,:));
n3=length(X3(1,:));
n4=length(X4(1,:));


% for w=2:n
%     if max(abs(X(:,w)))~=0
%     X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
%     end
% end

Y=T{1:11000,3}/mean(T{1:11000,3});
Theta1=zeros(n1,1);
Theta2=zeros(n2,1);
Theta3=zeros(n3,1);
Theta4=zeros(n4,1);
% 
%hypothesis 1
k1=1;

E1(k1)=(1/(2*m))*sum((X1*Theta1-Y).^2);

R=1;
while R==1
Theta1=Theta1-(Alpha/m)*X1'*(X1*Theta1-Y);
k1=k1+1
E1(k1)=(1/(2*m))*sum((X1*Theta1-Y).^2);
if E1(k1-1)-E1(k1)<0
    break
end 
q=(E1(k1-1)-E1(k1))./E1(k1-1);
if q <.0001;
    R=0;
end
end
figure (1)
plot(E1)

%hypothesis 2
k2=1;

E2(k2)=(1/(2*m))*sum((X2*Theta2-Y).^2);

R=1;
while R==1
Theta2=Theta2-(Alpha/m)*X2'*(X2*Theta2-Y);
k2=k2+1
E2(k2)=(1/(2*m))*sum((X2*Theta2-Y).^2);
if E2(k2-1)-E2(k2)<0
    break
end 
q=(E2(k2-1)-E2(k2))./E2(k2-1);
if q <.0001;
    R=0;
end
end
figure (2)
plot(E2)

%hypothesis 3
k3=1;

E3(k3)=(1/(2*m))*sum((X3*Theta3-Y).^2);

R=1;
while R==1
Theta3=Theta3-(Alpha/m)*X3'*(X3*Theta3-Y);
k3=k3+1
E3(k3)=(1/(2*m))*sum((X3*Theta3-Y).^2);
if E3(k3-1)-E3(k3)<0
    break
end 
q=(E3(k3-1)-E3(k3))./E3(k3-1);
if q <.0001;
    R=0;
end
end
figure (3)
plot(E3)

%hypothesis 4
k4=1;

E4(k4)=(1/(2*m))*sum((X4*Theta4-Y).^2);

R=1;
while R==1
Theta4=Theta4-(Alpha/m)*X4'*(X4*Theta4-Y);
k4=k4+1
E4(k4)=(1/(2*m))*sum((X4*Theta4-Y).^2);
if E4(k4-1)-E4(k4)<0
    break
end 
q=(E4(k4-1)-E4(k4))./E4(k4-1);
if q <.00001;
    R=0;
end
end
figure (4)
plot(E4)

%testing 
price_val=T{11001:17999,3};
price_val=price_val/mean(price_val);

bed_val=U(11001:17999,1);
bed_val=bed_val/mean(bed_val);

bath_val=U(11001:17999,2);
bath_val=bath_val/max(bath_val);


condition_val=U(11001:17999,8);
condition_val=condition_val/max(condition_val);

year_val=(U(11001:17999,12)-min(U(11001:17999,12)));
year_val=year_val/max(year_val);

Z_val=[bed_val bath_val condition_val year_val];

X1_val=[ones(6999,1) Z_val];

X2_val=[ones(6999,1) Z_val Z_val.^(2) Z_val.^(3) Z_val.^(4) Z_val.^(5)];

X3_val=[ones(6999,1) Z_val Z_val.^(2) Z_val.^(3) exp(Z_val)];

X4_val=[ones(6999,1) Z_val Z_val.^(2) Z_val.^(3) Z_val.^(4) exp(-Z_val)];


E1_val=(1/(2*6999))*sum((X1_val*Theta1-price_val).^2);
E2_val=(1/(2*6999))*sum((X2_val*Theta2-price_val).^2);
E3_val=(1/(2*6999))*sum((X3_val*Theta3-price_val).^2);
E4_val=(1/(2*6999))*sum((X4_val*Theta4-price_val).^2);
E_test=[E1_val E2_val E3_val E4_val]

E1_t=E1(k1)
E2_t=E2(k2)
E3_t=E3(k3)
E4_t=E4(k4)

E_training=[E1_t E2_t E3_t E4_t]


figure (5)
stem (1:4,E_test)
ylabel ('Testing')
hold on
stem (1:4,E_training)
ylabel ('Training')

E_final=min(E_test)

% %testing
% price_test=T{15001:17999,3};
% price_test=price_test/mean(price_test);
% 
% bed_test=U(15001:17999,1);
% bed_test=bed_test/mean(bed_test);
% 
% bath_test=U(15001:17999,2);
% bath_test=bath_test/max(bath_test);
% 
% 
% condition_test=U(15001:17999,8);
% condition_test=condition_test/max(condition_test);
% 
% year_test=(U(15001:17999,12)-min(U(15001:17999,12)));
% year_test=year_test/max(year_test);
% 
% Z_test=[bed_test bath_test condition_test year_test]
% 
% X_test=[ones(2999,1) Z_test Z_test.^(2) Z_test.^(3) exp(Z_test)];
% 
% 
% E_final=(1/(2*2999))*sum((X_test*Theta3-price_test).^2)






%%% This code is trying to acquire the best fit for the temprature 


tvrtem=csvread('tvrtem.csv',1,0);  %% Choose data with ignoring the first line in the file


T=tvrtem(:,4)+273;   %% temprature coloum T is in K


R=tvrtem (:,3);  %% Resistance coloum

V= tvrtem (:,2);  %% voltage colum
t= tvrtem (:,1);  %% Time colum

Tem= 1./T;

%%%% Tem = a+b.*log(R/1)+ c*log(R./1)^(3);


E= [ones(size(R)) , log(R) , log(R).^(3)];   %%% matrice E
Et=E.';   %%%% E transpose 
y= Tem;     %% y should not do a vector out of a avector

cons= (Et*E)\(Et*y);  %%%%% finding the values of a,b,c

a=cons(1);     %% define a
b=cons(2);      %% define b
c=cons(3);       %% define c
Tem = a+b.*(log(R)./1)+ c.*(log(R)./1).^(3);  %% Stienhart Eqt. for temprature
Tnew=1./Tem;  
diff=abs(Tnew-T);          %% Find the differnce of the points located away from the line
thresh=1.4;                  %% set your threshold value
x= find(diff<=thresh);       %% find values that corresponds to the scattered points 
disp (x);

%
Rx=R(x);
Ex= [ones(size(Rx)) , log(Rx) , log(Rx).^(3)];   %%% matrice E
Et=Ex.';   %%%% E transpose 
y= y(x);     %% y should not do a vector out of a avector

cons= (Et*Ex)\(Et*y);  %%%%% finding the values of a,b,c

a=cons(1);     %% define a
b=cons(2);      %% define b
c=cons(3);       %% define c
Temx = a+b.*log(R(x)./1)+ c.*log(R(x)./1).^(3);  %% Stienhart Eqt. for temprature
Tnew=1./Temx;  
% Temprature of the model with a,b,c
%%%%
disp(cons);           %%type values of a,b,c

figure (1);          %% initiate figure 1
plot(R(x),T(x),'.','markersize',7);   %% the plot of the Data Res.Vs. Temp
hold on 

xlabel('Resistance (Ohm)'); ylabel('Temperature (K)');
plot(R(x),Tnew,'r');                     %%% the plot of the model 
hold off  

% Find the differnce of the points located away from the line
                % set your threshold value

%%%%%%%%%%
figure (2);
%plot(t,T,'y.','markersize',10);      %% the plot of the Data Res.Vs. Temp
hold on 
plot(t(x),Tnew,'k');                        %%% the plot of the model 
hold on
xlabel('Time (s)'); ylabel('Temperature (K)');
hold off
%%%%%%%%%%%%%
figure(1);

                                                      



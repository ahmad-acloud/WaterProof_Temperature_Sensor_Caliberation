%%%%%%%%%%%%%%%%%%%%%
%Matlab Code ResT.m @Ahmad Almanassra
% In this code, the resonse time will be evaluated and used to made
% the plot of temperature  decay model and compare it to the measurment of
% temperature on a given range. Using the equation ln(tm(t)-tf)= ln(deltaT0* exp(-t/taw))
% where tm(t) is the temperature chosen,Tf-final temp., T0- Initial
% temp.and t is the time, in a matrix form, taw could be obtianed. the
% value of the response time (taw) was obtianed to be 1.8695 (s).   %
% The plot of temperature  decay model will be made and compared to the
% actual measurment in that given range. The model fit is accurate and the
% respnse time agrees with out data measurment.
%


clf; % CLEAR FIGURE
clear;
temd3=csvread('temd3.csv');
t= temd3 (:,1);  % Time colum
R = temd3(:,3);  %Resistance colum

%%%% initiate constant a,b and c coefficients %%%%%%%%%%%%

a =  0.8043 * 1.0e-03;  % values of a
b=  0.2942 * 1.0e-03;   % values of b
c=  -0.0002 * 1.0e-03;  % values of c
Tin = a+b.*log(R./1)+ c.*log(R./1).^(3);  %temprature inverse

T=1./Tin;     % Temprature

%%%%%% Caliberation of a certian range of data %%%%%%%
ind = 151:161;   % choose indices of temperature to test
Tm = T(ind);     % values of temperature of the given indices

T0= Tm(1);       % Initial temprature

Tf =Tm(end);  %final temp %mean (T(130:140));

Tv=(Tf-T0);         % Temperature difference

%%%%% EQUATION: ln(tm(t)-tf)= ln(deltaT0* exp(-t/taw))%%%%%%%%
Y=log((Tf-T(ind-1))./Tv);

k=t(ind)-150.5;    % our time corresponding to the decay we are intersted in

%%%%%%%%%%%%%%%%%%%%%%%%
%least squares fit to find a and tau
E= k;
Et=E.';                 % matrix transpose
cons= (Et*E)\(Et*Y);    % constant value
a=cons(1);
disp(a)
tau=-1./a;              %  taw (response time)
disp(tau);

%%%%%%%%%%%%%%%%%%%%%%%%
%Using estimate of tau to find the mode of temp.


%%%%%%%%%%%%%%%%%%%%%%%%

s= -k./tau;            % our value of the -t/taw

Tnew = Tf-((Tv)*exp(s));    % the model of the temp
figure (1)
clf
plot(k+150.5,Tnew,'r','markersize',12);   % the plot of temperature  decay model
hold on
plot(t,T,'o');       %  the plot of the time vs. temp.(observation)
xlabel('time (s)'); ylabel('temprature (K)');

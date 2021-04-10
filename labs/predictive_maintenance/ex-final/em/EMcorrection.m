  clear; clc

%===========================================================
function [T, StandDev,lambda]= ExpoTrain(NREX,tREX,Nsyst,FREX) 
  UT=tREX.*NREX;
  CumUT=sum(UT);
  ResidualUT=(Nsyst-sum(NREX))*(max(tREX)+1)
  MUT=(CumUT+ResidualUT)/Nsyst;
  lambda=1/MUT;
  Fexp=1-exp(-lambda.*tREX);
  T=mean(Fexp./FREX);
  StandDev=std(Fexp./FREX);
endfunction;
% Initialization of parameters and failures table
t=[0.5 1 1.5 2 3 4 5 6 7 8 9 10];
N=[31 29 27 26 46 41 36 32 28 24 22 19];
Nsyst=500;
SizeCensoredData=Nsyst-sum(N);


  Ncum(1)=N(1);
  for i=2:length(N),
    Ncum(i)=Ncum(i-1)+N(i);
  endfor;
  FREX=Ncum./Nsyst;

%===========================================================
% INITIALISATION
%===========================================================
% Initialization of EM. Training Parameters on complete data
[T,StandDev,lambda]=ExpoTrain(N,t,Nsyst,FREX)
for i=1:SizeCensoredData,
  tempo=(-1/lambda)*log(exprnd(lambda)/lambda);
  while tempo<=max(t); 
    tempo=(-1/lambda)*log(exprnd(lambda)/lambda);endwhile; 
CensoredData(i)=ceil(tempo);
CensoredData=sort(CensoredData);
endfor;

LAMBDA=[lambda]
TEST=[T];
STANDDEV=[StandDev];

for k=1:100,
  
%===========================================================
% ITERATION i
%===========================================================
% Création de la base complétée avec les données censurées et ré apprentissage de lambda
tCensored=[]; NCensored=[]; clear TimeTempo NTempo Ncum
for j=min(CensoredData) : max(CensoredData)
  tCensored=[tCensored j];
  NCensored=[NCensored length(find(CensoredData==j))];
  endfor

  TimeTempo=[t tCensored];
  NTempo=[N NCensored];
  Ncum(1)=NTempo(1);
  for i=2:length(NTempo),
    Ncum(i)=Ncum(i-1)+NTempo(i);
  endfor;
  FREX=Ncum./Nsyst;
  %disp(' ')
  %k
  [Tk,StandDevk,lambdak]=ExpoTrain(NTempo,TimeTempo,Nsyst,FREX);
  LAMBDA=[LAMBDA lambdak];
  TEST=[TEST Tk];
  STANDDEV=[STANDDEV StandDevk];
  
% Mise à jour des valeurs des données censurées en utilisant la nouvelle valeur de lambda
for i=1:SizeCensoredData,
  tempo=(-1/lambdak)*log(exprnd(lambdak)/lambdak);
  while tempo<=max(t); 
    tempo=(-1/lambdak)*log(exprnd(lambdak)/lambdak);endwhile; 
CensoredData(i)=ceil(tempo);
CensoredData=sort(CensoredData);
endfor;

endfor

plot(LAMBDA)
figure, plot(TEST)
figure, plot(STANDDEV)
  

% Processing of right censored data


    
    

% Update of UT and lambda



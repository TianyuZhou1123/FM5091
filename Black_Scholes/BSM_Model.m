% assign value for standard gaussian distribution with mean=0 and standard variance = 1
mu = 0;
sigma0 = 1;

d1 = @(S,K,r,sigma,T) (log(S ./ K) + (r+(sigma .* sigma)/2).*T) ./ (sigma .* sqrt(T));
%d1 One parameter of Black-Scholes Model.
%   You should enter in S,K,R,SIGMA and T to run this function.
%   Every parameter can be a vector.

d2 = @(S,K,r,sigma,T) d1(S,K,r,sigma,T) - (sigma .* sqrt(T));
%d2 Another parameter of Black-Scholes Model.
%   You should enter in S,K,R,SIGMA and T to run this function
%   Every parameter can be a vector.

Cprice = @(S,K,r,sigma,T) S .* cdf('Normal',d1(S,K,r,sigma,T),mu,sigma0) - K .* exp(-r.*T) .* ...
                          cdf('Normal',d2(S,K,r,sigma,T),mu,sigma0); 
% cdf is a cumulative distribution function. 
%Cprice Calculate the call option price according to Black-Scholes Model.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Pprice = @(S,K,r,sigma,T) K .* exp(-r.*T) .* cdf('Normal',-d2(S,K,r,sigma,T),mu,sigma0) - ...
                          S .* cdf('Normal',-d1(S,K,r,sigma,T),mu,sigma0);
%Pprice Calculate the put option price according to Black-Scholes Model.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Cdelta = @(S,K,r,sigma,T) cdf('Normal',d1(S,K,r,sigma,T),mu,sigma0);
%Cdelta Calculate the call option delta.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Pdelta = @(S,K,r,sigma,T) cdf('Normal',d1(S,K,r,sigma,T),mu,sigma0)-1;
%Pdelta Calculate the put option delta.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Parameter S can be a vector.

Cgamma = @(S,K,r,sigma,T) pdf('Normal',d1(S,K,r,sigma,T),mu,sigma0) ./ (S .* sigma .* sqrt(T));
% pdf is a Probability density function.
%Cgamma Calculate the call option gamma.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Cvega = @(S,K,r,sigma,T) S .* pdf('Normal',d1(S,K,r,sigma,T),mu,sigma0) .* sqrt(T);
%Cvega Calculate the call option vega.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Ctheta = @(S,K,r,sigma,T) -r .* K .*exp(-r .* T) .* cdf('Normal',d2(S,K,r,sigma,T),mu,sigma0) - ... 
                         (S .* pdf('Normal',d1(S,K,r,sigma,T),mu,sigma0) .* sigma) ./ (2*sqrt(T));
%Ctheta Calculate the call option theta.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Ptheta = @(S,K,r,sigma,T) r .* K .* exp(-r.*T) .* cdf('Normal',-d2(S,K,r,sigma,T),mu,sigma0) - ... 
                         (S .* pdf('Normal',d1(S,K,r,sigma,T),mu,sigma0) .* sigma) ./ (2*sqrt(T));
%Ptheta Calculate the put option theta.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Crho = @(S,K,r,sigma,T) K .* T .* exp(-r.*T) .* cdf('Normal',d2(S,K,r,sigma,T),mu,sigma0);
%Crho   Calculate the call option rho.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector.

Prho = @(S,K,r,sigma,T) -K .* T .* exp(-r.*T) .* cdf('Normal',-d2(S,K,r,sigma,T),mu,sigma0);
%Prho   Calculate the put option rho.
%       You should enter in S,K,R,SIGMA and T to run this function
%       Every parameter can be a vector..

%assign actual values to inputs
S = 50; K =50; r = 0.05; sigma = 0.5; T =1;

%display actual values for those inputs defined here
Cprice_1 = Cprice(S,K,r,sigma,T);
Pprice_1 = Pprice(S,K,r,sigma,T);
Cdelta_1 = Cdelta(S,K,r,sigma,T);
Pdelta_1 = Pdelta(S,K,r,sigma,T);
Cgamma_1 = Cgamma(S,K,r,sigma,T);
Cvega_1 = Cvega(S,K,r,sigma,T);
Ctheta_1 = Ctheta(S,K,r,sigma,T);
Ptheta_1 = Ptheta(S,K,r,sigma,T);
Crho_1 = Crho(S,K,r,sigma,T);
Prho_1 = Prho(S,K,r,sigma,T);

% Jsut give an example, when the stock price change, how about the delta of
% the call option? A graph will show it.

% Assign a vector to S1, and a number to K1, r1, sigma1, T1.
S1 = [30 35 40 45 50 55 60 65 70];
K1 = 50; r1 = 0.05; sigma1 = 0.5; T1 =1;
% Calculate the delta.
Cdelta_2 = Cdelta(S1,K1,r1,sigma1,T1);
% Show the correlation between delta and underlying price.
plot(S1,Cdelta_2,'b -*','LineWidth',1.5)
xlabel('Underlying Price');
ylabel('Delta');
title('The Correlation Between Delta and Underlying Price');
legend('Delta of call option','Location','NorthWest');








function [imp_vol, itr] = Newton_vol(optpx, S, K, r, T, type)
%This is a function using Newton's method to calculate the implied
% volatility of the option and number of iterations to get this answer.
% The parameter optpx is the observed market option price.
% All the parameters can be vectors. 
% Tpye is a vector states type of options. type = 1 means call option, 
% type = 0 means put option 

% Make sure the input are right.
if nargin < 6
    disp('The function must include 6 parameters');
end

% Define the initial volatility, iteration number, guess volatility, delta volatility and accuracy.
imp_vol = zeros(1,length(optpx));
itr = zeros(1,length(optpx));
guess_vol = 0.25 * ones(1,length(optpx));
delta_vol = zeros(1,length(optpx));
tol = 0.00001;

% Define bls option pricing model.
d1 = @(S,K,r,vol,T) (log(S ./ K) + (r+(vol .* vol)/2).*T) ./ (vol .* sqrt(T));
d2 = @(S,K,r,vol,T) d1(S,K,r,vol,T) - (vol .* sqrt(T));
callpx = @(S,K,r,vol,T) S .* normcdf(d1(S,K,r,vol,T)) - K .* exp(-r.*T) .* normcdf(d2(S,K,r,vol,T));
putpx = @(S,K,r,vol,T) K .* exp(-r.*T) .* normcdf(-d2(S,K,r,vol,T)) - S .* normcdf(-d1(S,K,r,vol,T)); 

% Define the partial derivative of option price with respect to volatility.
vega = @(S,K,r,vol,T,i) S(i) .* normpdf(d1(S(i),K(i),r(i),vol(i),T(i))) .* sqrt(T(i));

% Define a function of differnces between therotical and practical option price.
f_call = @(vol,i) optpx(i) - callpx(S(i),K(i),r(i),vol(i),T(i));
f_put =  @(vol,i) optpx(i) - putpx(S(i),K(i),r(i),vol(i),T(i));


% Do the interation to every option type.
for i = 1:length(type)
    % Judge if the ith value means a call option. 
    if type(i) == 1
        % Do the iteration unless the diffences are less than the accuracy.
        while( abs(f_call(guess_vol,i)) >= tol)    
           itr(i) = itr(i) + 1;
           % Newton's Method Formula
           delta_vol(i) = f_call(guess_vol,i) / vega(S,K,r,guess_vol,T,i);
           guess_vol(i) = delta_vol(i) + guess_vol(i);    
        end
        % Define the output
        imp_vol(i) = guess_vol(i);
    
    elseif type(i) == 0
        % Do the iteration unless the diffences are less than the accuracy.
        while( abs(f_put(guess_vol,i)) >= tol)    
           itr(i) = itr(i) + 1;
           % Newton's Method Formula
           delta_vol(i) = f_put(guess_vol,i) / vega(S,K,r,guess_vol,T,i);
           guess_vol(i) = delta_vol(i) + guess_vol(i);    
        end
         % Define the output
        imp_vol(i) = guess_vol(i);
     
    else
        % If neither call or put option, report the error.
        disp('Please make sure the vector "type" only includes value 0 and 1');
     
    end
end
        


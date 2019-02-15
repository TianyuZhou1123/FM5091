function [imp_vol, itr] = bisect_vol(optpx, S, K, r, T, type)
%This is a function using bisection method to calculate the implied
% volatility of the option and number of iterations to get this answer.
% The parameter optpx is the observed market option price. 
% All the parameters can be vectors. 
% Tpye is a vector states type of options. type = 1 means call option, 
% type = 0 means put option 

% Make sure the input are right.
if nargin < 6
    disp('The function must include 6 parameters');
end

% Define the initial endpoint values, iteration number and accuracy.
imp_vol = zeros(1,length(optpx));
itr = zeros(1,length(optpx)); 
c = zeros(1,length(optpx)); 
min_vol = -2 * ones(1,length(optpx));
max_vol = 2 * ones(1,length(optpx));
tol = 0.0001;

% Define bls option pricing model.
d1 = @(S,K,r,vol,T) (log(S ./ K) + (r+(vol .* vol)/2).*T) ./ (vol .* sqrt(T));
d2 = @(S,K,r,vol,T) d1(S,K,r,vol,T) - (vol .* sqrt(T));
callpx = @(S,K,r,vol,T) S .* normcdf(d1(S,K,r,vol,T)) - K .* exp(-r.*T) .* normcdf(d2(S,K,r,vol,T));
putpx = @(S,K,r,vol,T) K .* exp(-r.*T) .* normcdf(-d2(S,K,r,vol,T)) - S .* normcdf(-d1(S,K,r,vol,T));

% Define functions of differnces between therotical and practical option price.
f_call = @(vol,i) callpx(S(i),K(i),r(i),vol(i),T(i)) - optpx(i);
f_put = @(vol,i) putpx(S(i),K(i),r(i),vol(i),T(i)) - optpx(i);

% Do the interation to every option type.
for i = 1:length(type)
    % Judge if the ith value means a call option. 
    if type(i) == 1
        % Do the iteration unless the multiplied values more than 0 or the diffences are less than the accuracy.       
        while (f_call(min_vol,i)*f_call(max_vol, i) < 0) && (abs(max_vol(i)-min_vol(i)) >= tol)
            % The followings are how bisection method works.
            c(i) = 0.5 * (min_vol(i) + max_vol(i));
            itr(i) = itr(i) + 1;
    
            if f_call(c,i)*f_call(max_vol,i) <= 0      
                min_vol(i) = c(i);
            elseif f_call(min_vol,i)*f_call(c,i) <= 0
                max_vol(i) = c(i);    
            end
    
        end   

        % Define the output
        imp_vol(i) = 0.5 * (min_vol(i) + max_vol(i));
        
        
    % Judge if the ith value means a put option. 
    elseif type(i) == 0
        % Do the iteration unless the multiplied values more than 0 or the diffences are less than the accuracy.       
        while (f_put(min_vol,i)*f_put(max_vol,i) < 0) && (abs(max_vol(i)-min_vol(i)) >= tol)
            % The followings are how bisection method works.
            c(i) = 0.5 * (min_vol(i) + max_vol(i));
            itr(i) = itr(i) + 1;
    
            if f_put(c,i)*f_put(max_vol,i) <= 0      
                min_vol(i) = c(i);
            else
                max_vol(i) = c(i);    
            end
    
        end   

        % Define the output
        imp_vol(i) = 0.5 * (min_vol(i) + max_vol(i));
        
    else
        % If neither call or put option, report the error.
        disp('Please make sure the vector "type" only includes value 0 and 1');
    end
end
        
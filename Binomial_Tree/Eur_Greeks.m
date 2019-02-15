function [delta_call, gamma_call, vega_call, rho_call, theta_call, ...
          delta_put, gamma_put, vega_put, rho_put, theta_put] = ...
          Eur_Greeks(S, K, r, sigma, T, N, q)
%This is a function to calculate the Greeks of European call and put options.
% The parameter N is the step of the binomial tree, q is the dividend, the units of T is a year.
% Please enter S, K, r, sigma, T, N, q in order.

   % Difine every interval of the step.
   dt = T/N;
   % Difine the fluctuation value of sigma for calculating vega later.
   diff_sig = 0.001*sigma;
   % Difine the fluctuation value of time for calculating rho later.
   diff_r = 0.001*r;
   
   % Using the function to calculate the call and put option value matrixes
   % and matrix of possible underlying price
   [~,~,V_call] = Eur_option_binomial(S, K, r, sigma, T, N, q);
   [~,~,~,V_put] = Eur_option_binomial(S, K, r, sigma, T, N, q);
   [~,~,~,~,St] = Eur_option_binomial(S, K, r, sigma, T, N, q);
   % Calculate call and put option prices when the sigma changes. 
   [callpx_plu_sig, putpx_plu_sig] = Eur_option_binomial(S, K, r, sigma+diff_sig, T, N, q);
   [callpx_min_sig, putpx_min_sig] = Eur_option_binomial(S, K, r, sigma-diff_sig, T, N, q);
   % Calculate call and put option prices when the r changes.
   [callpx_plu_r, putpx_plu_r] = Eur_option_binomial(S, K, r+diff_r, sigma, T, N, q);
   [callpx_min_r, putpx_min_r] = Eur_option_binomial(S, K, r-diff_r, sigma, T, N, q);

    % Define the anonymous function for calculating delta,gamma,vega,rho and theta.
    delta = @(V, St_init) (V(1,2) - V(2,2)) / (St_init(1,2) - St_init(2,2));
    
    gamma = @(V, St_init) (((V(1,3) - V(2,3)) / (St_init(1,3) - St_init(2,3))) - ...
                          ((V(2,3) - V(3,3)) / (St_init(2,3) - St_init(3,3)))) / ...
                          (0.5 * (St_init(1,3)-St_init(3,3)));
                      
    vega = @(px_plu_sig, px_min_sig, diff_s) (px_plu_sig - px_min_sig) / (2*diff_s);
    
    rho = @(px_plu_r, px_min_r, diff_rr) (px_plu_r - px_min_r) / (2*diff_rr);
    
    theta = @(V, St_init) (V(2,3) - V(1,1)) / (2*dt);
   
    
    % Substitute responding parameter to calculate the Greeks.
    delta_call = delta(V_call, St);
    delta_put = delta(V_put, St);
   
    gamma_call = gamma(V_call, St);
    gamma_put = gamma(V_put, St);
   
    vega_call = vega(callpx_plu_sig, callpx_min_sig, diff_sig);
    vega_put = vega(putpx_plu_sig, putpx_min_sig, diff_sig);
    
    rho_call = rho(callpx_plu_r, callpx_min_r, diff_r);
    rho_put = rho(putpx_plu_r, putpx_min_r, diff_r);
    
    theta_call = theta(V_call, St);
    theta_put = theta(V_put, St);
 
end
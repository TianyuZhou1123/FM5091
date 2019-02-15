function [A_call_px, A_put_px, V_call, V_put, St] = American_option_binomial(S, K, r, sigma, T, N, q)
%This is a function to calculate American put and call options' price(A_call_px and A_put_px),
% option values matrix(V_call and V_put) and estimated underlying price matrix(St), using binomial tree.
% The parameter N is the step of the binomial tree, q is the dividend, the units of T is a year.
% Please enter S, K, r, sigma, T, N, q in order.

    % Difine the time interval.
    dt = T/N;    
    u = exp(sigma * sqrt(dt));
    d = exp(-sigma * sqrt(dt));
    % pu and pd are Probability of up and down under risk neutrality measure.
    pu = (exp((r-q)*dt)-d) / (u-d);
    pd = 1-pu;
    % Define the discount.
    disc = exp(-r*dt);
    % Pre-calculate the pu and pd of discount to improve efficiency of the
    % loop in the following code.
    disc_pu = disc * pu;
    disc_pd = disc * pd;

    % Initiate the outcomes.
    St = zeros(N+1);
    V_call = zeros(N+1);
    V_put = zeros(N+1);
    
    % Calculate the underlying price if it always goes down in the whole period.
    St(N+1,N+1) = S*d^N;
    % Calculate all the possible underlying price at the last step.
    for j = N:-1:1
        St(j,N+1) = St(j+1,N+1)*u/d;
    end
    
% Calculate the American call option price and matrixes.
     % Calculate the payoff of the last step.
     for j = (N+1):-1:1
         V_call(j,N+1) = max(St(j,N+1)-K, 0);
     end
     
     % Calculate value of the option at each step except for the last step.
     % i-1 means which step the process goes.
     for i = N:-1:1
         for j = i:-1:1
             % Use the i+1 step to calculate expected value of the option at i step.
             V_call(j,i) = disc_pu * V_call(j,i+1) + disc_pd * V_call(j+1,i+1);
             % Use the i+1 step to calculate the underlying price at i step.
             St(j,i) = St(j+1,i+1) / d;
             % Compare the expected value and payoff of the call option at i step.
             V_call(j,i) = max(V_call(j,i), St(j,i)-K);
         end
     end
     % Extract the call option value.
     A_call_px = V_call(1,1);
     
% Calculate the American put option price and matrixes.
    % Calculate the payoff of the last step.  
    for j = (N+1):-1:1
        V_put(j,N+1) = max(K-St(j,N+1), 0);
    end
    
    % Calculate value of the option at each step except for the last step.
    % i-1 means which step the process goes. 
    for i = N:-1:1
        for j = i:-1:1
            % Use the i+1 step to calculate expected value of the option at i step.
            V_put(j,i) = disc_pu * V_put(j,i+1) + disc_pd * V_put(j+1,i+1);
            % Use the i+1 step to calculate the underlying price at i step.
            St(j,i) = St(j+1,i+1) / d;
            % Compare the expected value and payoff of the put option at i step.
            V_put(j,i) = max(V_put(j,i), K-St(j,i));
        end
    end
    
    % Extract the put option value.
    A_put_px = V_put(1,1);        
       
end


    
   
   
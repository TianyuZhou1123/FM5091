function [vec, val, prop] = PCA_Calculate(orig_data)
%This is a function to calculate eigenvalue, eigenvectors and proportion of every eigenvalue.
% The parameter is original data.

   % Calculate the return of each stock
   returns = log(orig_data(2:end,:) ./ orig_data(1:end-1,:));
   % Calculate the covariance of 4 stocks
   cov_matrix = cov(returns);
   % Calculate the eigvalues and eigvectors
   [vec, val] = eig(cov_matrix);

   % Calculate proportion of each eigvalue.
   prop = zeros(4,1);
   for i = 1:4
       perc = val(i,i) / sum(val(:));
       prop(i) = perc;
   end
   % Sort the proportion from large to small
   prop = sort(prop,'descend');
end

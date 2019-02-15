%% Read data from database
MSFT = read_SQL('1');
GE = read_SQL('2');
BP = read_SQL('3');
KO = read_SQL('4');
GOOG = read_SQL('5');
AMZN = read_SQL('6');
AAPL = read_SQL('7');

%% PCA For Different Sectors
msft = table2array(MSFT(:,6));
ge = table2array(GE(:,6));
bp = table2array(BP(:,6));
ko = table2array(KO(:,6));
% Combine the 4 stocks' close price
Hybid = [msft ge bp ko];
% Calculate the return of each stock
hybid_returns = log(Hybid(2:length(Hybid),:) ./ Hybid(1:length(Hybid)-1,:));
% Calculate eigenvalue, eigenvectors and proportion of every eigenvalue.
[hybidvect, hybidval, prop_hybid] = PCA_Calculate(Hybid);
% Output the result
disp('The four ticker symbols are MSFT, GE, BP, KO')
disp('The matrix of eigenvalues is ')
disp(hybidval)
disp('The proportion of variation accounted for by the largest eigenvalue is')
disp(prop_hybid(1))

% Create a matrix that, when transposed,the most relevant eigenvector is
% the top row.
pca_vect_h = [hybidvect(:,4) hybidvect(:,3) hybidvect(:,2)];
% Subtracting the mean from each column of original data.
newh_returns = hybid_returns - mean(hybid_returns);
% Create new dimentional matrix.
hybid_approx = pca_vect_h' * newh_returns';

% Reconstruct original data
new_hybid = (pca_vect_h * hybid_approx)';
new_hybid = new_hybid + mean(hybid_returns);

% Plot the original data
subplot(3,1,1);
plot(hybid_returns, '.');
title('Original Data of Hybid Sector');
axis([1 length(hybid_returns)+5 -0.13  0.1]);
% Plot the new dimentional matrix
subplot(3,1,2);
plot(hybid_approx', '.');
title('3-Dimentional Hybid Sector');
axis([1 length(hybid_approx)+5 -0.13  0.1]);
% Plot the reconstructed data
subplot(3,1,3);
plot(new_hybid, '.');
title('Reconstructed Data of Hybid Sector');
axis([1 length(new_hybid)+5 -0.13  0.1]);



%% PCA for Same Sectors
msft = table2array(MSFT(:,6));
aapl = table2array(AAPL(:,6));
amzn = table2array(AMZN(:,6));
goog = table2array(GOOG(:,6));

% Combine the 4 stocks' close price
tech = [msft aapl amzn goog];
% Calculate the return of each stock
tech_returns = log(tech(2:length(tech),:) ./ tech(1:length(tech)-1,:));
% Calculate eigenvalue, eigenvectors and proportion of every eigenvalue.
[techvect, techval, prop_tech] = PCA_Calculate(tech);
% Output the result
disp('The four ticker symbols are MSFT, AAPL, GOOG, AMZN')
disp('The matrix of eigenvalues is ')
disp(techval)
disp('The proportion of variation accounted for by the largest eigenvalue is')
disp(prop_tech(1))


% Create a matrix that, when transposed,the most relevant eigenvector is
% the top row.
pca_vect = [techvect(:,4) techvect(:,3) techvect(:,2)];
% Subtracting the mean from each column of original data.
new_returns = tech_returns - mean(tech_returns);
% Create new dimentional matrix.
tech_approx = pca_vect' * new_returns';

% Reconstruct original data
new_tech = (pca_vect * tech_approx)';
new_tech = new_tech + mean(tech_returns);

figure
% Plot the original data
subplot(3,1,1);
plot(tech_returns, '*');
title('Original Data of Technology Sector');
axis([1 length(tech_returns)+5 -0.13  0.1]);
% Plot the new dimentional matrix
subplot(3,1,2);
plot(tech_approx', '*');
title('3-Dimentional Technology Sector');
axis([1 length(tech_approx)+5 -0.13  0.1]);
% Plot the reconstructed data
subplot(3,1,3);
plot(new_tech, '*');
title('Reconstructed Data of Technology Sector');
axis([1 length(new_tech)+5 -0.13  0.1]);



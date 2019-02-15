%% Add information of instruments
add_name('Microsoft', 'MSFT', 'NASDAQ');
add_name('General Electric', 'GE', 'NYSE');
add_name('BP', 'BP', 'NYSE');
add_name('Coca-Cola', 'KO', 'NYSE');
add_name('Google', 'GOOG', 'NASDAQ');
add_name('Amazon', 'AMZN', 'NASDAQ');
add_name('Apple', 'AAPL', 'NASDAQ');

%% Add information of HistPrices
add_timeseries_from_csv('MSFT','MSFT.csv');
add_timeseries_from_csv('GE','GE.csv');
add_timeseries_from_csv('BP','BP.csv');
add_timeseries_from_csv('KO','KO.csv');
add_timeseries_from_csv('GOOG','GOOG.csv');
add_timeseries_from_csv('AMZN','AMZN.csv');
add_timeseries_from_csv('AAPL','AAPL.csv');

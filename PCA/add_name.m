function add_name(company, ticker, market)
   conn = database('SQL', '', '');
   
   colnames = {'CompanyName';'StockTicker';'Market'};
   coldata = {company, ticker, market};
   
   fastinsert(conn, 'MFM_Financial.FinData.Instrument', colnames, coldata);
   
   close(conn);
end
   
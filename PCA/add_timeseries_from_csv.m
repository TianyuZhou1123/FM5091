%This m-file is intended to add a set of timeseries data from a Yahoo!
%finance CSV download.  The inputs required are the ticker of the company
%and a CSV or XLS data file in Yahoo! finance format.
%Syntax: [ID]=add_timeseries_from_csv(ticker,XLS_filepath) 

function [ID]=add_timeseries_from_csv(ticker,csv_filepath)
   ID = get_name_id(ticker);
   if(isnumeric(ID) == 1)
       conn = database('SQL', '', '');
       colnames = {'InstID'; 'Date'; 'OpenPrice'; 'HighPrice'; 'LowPrice'; 'ClosePrice'; 'Volume'};
       [num,txt] = xlsread(csv_filepath);
       
       dated = datestr(txt(2:length(txt),1), 'yyyy-mm-dd');
       
       for i = 1:length(num)
           coldata = {ID, dated(i,:), num(i,1), num(i,2), num(i,3), num(i,4), num(i,6)};
           fastinsert(conn, 'MFM_Financial.FinData.HistPrices', colnames, coldata);
       end
       
       close(conn);
   end

end


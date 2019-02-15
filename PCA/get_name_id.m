%This m-file is intended to get a company's ID from the%MFM_Financial.FinData.Instrument table.
%Syntax: [ID]=get_name_id(ticker)
function [ID]=get_name_id(ticker)
%Set preferences with setdbprefs
  setdbprefs('DataReturnFormat', 'numeric');
  setdbprefs('NullNumberRead', 'NaN');
  setdbprefs('NullStringRead', 'null');
  
  conn = database('SQL', '', '');
  
  curs = exec(conn, ['SELECT Instrument.ID FROM MFM_Financial.FinData.Instrument where StockTicker = ''', ticker, '''']);
  
  curs = fetch(curs);
  ID = curs.Data;
  close(conn);
  
end
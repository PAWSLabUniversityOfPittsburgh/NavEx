logintimeout(5);
conn = database('4MatLab', '', '');
curs = exec(conn, 'SELECT ALL user_id FROM user_activity WHERE application_id = 9');
setdbprefs('DataReturnFormat','numeric');
%setdbprefs('DataReturnFormat','cellarray');
%curs = fetch(curs, 10);
curs = fetch(curs);
AA = curs.Data;
close(curs);
close(conn);
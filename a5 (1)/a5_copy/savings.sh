#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib

# Andre Ceschia: 501156295
# Numair Jaan: 501113345
# Ty Tsiamala: 501168084



sqlplus64 "aceschia/12106295@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF >out.txt
SET LINESIZE 200
SET WRAP OFF
SET FEEDBACK ON

COLUMN USER_ID FORMAT 99999999
COLUMN FIRST_NAME FORMAT A20
COLUMN LAST_NAME FORMAT A20

SELECT U.first_name, U.last_name FROM users U
JOIN account A on A.user_id=U.user_id
WHERE EXISTS
    (SELECT account_id FROM savings_account SA
    WHERE A.account_id=SA.account_id
    )
;
exit;

EOF

bash pretty_print.sh

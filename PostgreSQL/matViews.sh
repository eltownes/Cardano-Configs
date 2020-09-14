#!/bin/bash
usr=\""mike\""

while getopts e:b: option
do
case "${option}"
in
e) m_Epoch=${OPTARG};;
b) m_Blocks=${OPTARG};;
esac
done

# create/recreate = 1  |  drop = 2  |  refresh = 3

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
# m_Epoch
if [ $m_Epoch == 1 ] | [ $m_Epoch == 2 ] ; then
  psql --dbname=cexplorer --command="DROP MATERIALIZED VIEW IF EXISTS public.\""m_Epoch\"";"
fi
# create
if [ $m_Epoch == 1 ] ; then
  psql --dbname=cexplorer --command="
  CREATE MATERIALIZED VIEW public.\""m_Epoch\""
  AS
    SELECT epoch.no AS \""epochNo\"",
      epoch.start_time AS \""epochStart\"",
      epoch.end_time AS \""epochEnd\"",
      epoch.blk_count AS \""epochBlkCnt\"",
      epoch.tx_count AS \""epochTxCnt\"",
      epoch.out_sum AS \""epochOut-B\""
    FROM epoch
    ORDER BY epoch.end_time DESC
  WITH DATA;

ALTER TABLE public.\""m_Epoch\""
  OWNER TO $usr;
"
fi
if [ $m_Epoch == 3 ] ; then
  psql --dbname=cexplorer --command="REFRESH MATERIALIZED VIEW public.\""m_Epoch\"";"
fi
echo "m_Epoch done"

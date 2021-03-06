#!/bin/bash

#
# Rsync files from DFB3 correlator disk drive at Parkes to
# incoming DFB3 directory at Epping. Redirect the output to
# a log file.
#
# Note: Must be run from the 'pulsar' account.
#
# Author: Jonathan Khoo
# Date:   25.01.11
#

user=`whoami`

if [ $user != 'pulsar' ]
then
  echo $0 must be run from the 'pulsar' account.
  exit
fi

pipeline_status=`/var/www/vhosts/psrdatamanagement.atnf.csiro.au/scripts/cron/src/pipeline_status.py`

if [ $pipeline_status == 'True' ]
then
  /usr/bin/rsync -av --size-only --progress --include "*.cf" --include "*.rf" --exclude "*" "corr@pkccc3:/data1/PDFB3_1/*" /pulsar/archive21/incoming_files/DFB3/ > /var/www/vhosts/psrdatamanagement.atnf.csiro.au/htdocs/prod/logs/rsync_dfb3.txt

  echo "" >> /var/www/vhosts/psrdatamanagement.atnf.csiro.au/htdocs/prod/logs/rsync_dfb3.txt
  date >> /var/www/vhosts/psrdatamanagement.atnf.csiro.au/htdocs/prod/logs/rsync_dfb3.txt
fi

exit

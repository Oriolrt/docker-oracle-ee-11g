#!/bin/bash

set -e


cat /etc/security/limits.conf | grep -v oracle | tee /etc/security/limits.conf

Final="https://od.lk/d/MjFfMTIxMjAyMzFf/linux11gR2.zip"
prefix="https://od.lk/d/MjFfMTIxMjAyMzFf/linux11gR2.z"
for i in $(seq 1 22)
do
	nom="$prefix$( printf '%.2d' $i )";
    echo "downloading ${nom}"
    wget $nom 
done
wget $Final 
zip -s 0 linux11gR2.zip --out complete.zip
echo 'Unzipping'
unzip -q complete.zip
rm complete.zip
rm -rf linux11gR2.z*

#echo 'Downloading linux.x64_11gR2_database_1of2.zip'
#file1="linux.x64_11gR2_database_1of2.zip"
#file2="linux.x64_11gR2_database_2of2.zip"
#[ ! -f $file1 ] && wget https://ufile.io/9z7sd   -O $file1
#echo 'Downloading linux.x64_11gR2_database_2of2.zip'
#[ ! -f $file2 ] && wget https://ufile.io/0v6jq  -O $file2
#cd /install
#echo 'Unzipping'
#unzip -q $file1
#unzip -q $file2
#rm -f linux*.zip

mv database /home/oracle/
cd /

su oracle -c 'cd /home/oracle/database && ./runInstaller -ignorePrereq -ignoreSysPrereqs -silent -responseFile /install/oracle-11g-ee.rsp -waitForCompletion 2>&1'
rm -rf /home/oracle/database

/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/EE/root.sh

mv /u01/app/oracle/product /u01/app/oracle-product

cat >> /home/oracle/.bash_profile  <<-EOF
ORACLE_SID=EE
ORACLE_HOME=/u01/app/oracle/product/11.2.0/EE
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$ORACLE_HOME/bin
LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$ORACLE_HOME/lib
export ORACLE_SID ORACLE_HOME PATH LD_LIBRARY_PATH
EOF



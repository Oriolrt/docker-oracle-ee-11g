#/bin/bash

echo "installing required packages"


yum -y update; yum clean all
yum install -y yum install \
	oracle-rdbms-server-11gR2-preinstall \
	glibc-static \
	wget \
	unzip \
	openssh-server \
	passwd \
	vim \
       	vixie-cron &&\
       	yum clean all &&\
	 rm -rf /var/cache/yum

mkdir /u01 && chown oracle:dba /u01
recovery_files="/u02/recovery_files"
mkdir -p $recovery_files && chown oracle:dba $recovery_files
table_spaces="/u03/tbs"
mkdir -p $table_spaces && chown oracle:dba $table_spaces
echo "shared volumes: $recovery_files and $table_spaces created"

echo oracle:oracle | chpasswd

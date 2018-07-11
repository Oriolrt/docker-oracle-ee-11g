FROM oraclelinux

MAINTAINER Oriol Ramos Terrades <oriol.ramos@uab.cat>


ADD setup.sh /setup.sh
RUN ./setup.sh && rm -rf setup.sh


ADD install /install
RUN  /install/oracle_install.sh
RUN rm -rf install


ENV DBCA_TOTAL_MEMORY 2048
ENV WEB_CONSOLE false

ENV ORACLE_SID=EE
ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/EE
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib

ADD entrypoint.sh /entrypoint.sh

VOLUME ["/docker-entrypoint-initdb.d"]

RUN mkdir /var/run/sshd
RUN rm -rf /etc/ssh/ssh*key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t Ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

EXPOSE 22
EXPOSE 8080
EXPOSE 1521

CMD bash
#ENTRYPOINT ["/entrypoint.sh"]

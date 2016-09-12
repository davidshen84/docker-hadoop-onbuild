FROM openjdk:8-jre
MAINTAINER Xi Shen <davidshen84@gmail.com>

LABEL hadoop=2.7.3 jre=openjdk:8

ENV HADOOP_PREFIX "/opt/hadoop-2.7.3/"

ONBUILD RUN apt-get update && apt-get install -y \
    ssh
ONBUILD COPY .ssh /root/.ssh

ADD hadoop-2.7.3.tar.gz /opt/

COPY opt/ /opt/
COPY startup.sh /root/
RUN mkdir -p /opt/hadoop

EXPOSE \
       # dfs.namenode.http-address
       50070 \
       # dfs.datanode.http.address
       50075 \
       # yarn.nodemanager.webapp.address
       8042 \
       # yarn.resourcemanager.webapp.address
       8088 \
       # fs.defaultFS
       9000 \
       # mapreduce.jobhistory.webapp.address
       19888

VOLUME ["/opt/hadoop/"]
WORKDIR /opt/hadoop-2.7.3/

ENTRYPOINT ["/root/startup.sh"]

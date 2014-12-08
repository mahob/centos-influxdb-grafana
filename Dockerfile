FROM centos:centos6
MAINTAINER MArkus B. <iammhob@gmail.com>

# Install prerequisites
RUN yum -y install wget

# Install influxdb
# see: http://influxdb.com/docs/v0.8/introduction/installation.html
RUN wget http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm
RUN rpm -ivh influxdb-latest-1.x86_64.rpm

# Install grafana


# Start the influxdb daemon
RUN /etc/init.d/influxdb start

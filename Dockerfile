FROM centos:centos6
MAINTAINER Markus B. <iammhob@gmail.com>

# Set environment variables
ENV GRAFANA_VERSION "1.9.0"
ENV GRAFANA_BASEDIR "/apps/grafana"
ENV GRAFANA_DOWNLOAD_URL "http://grafanarel.s3.amazonaws.com/grafana-1.9.0.tar.gz"
ENV INFLUXDB_DATABASE "db1"

# Install prerequisites
RUN yum -y install wget tar gzip

# Install influxdb
# see: http://influxdb.com/docs/v0.8/introduction/installation.html
RUN wget http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm
RUN rpm -ivh influxdb-latest-1.x86_64.rpm

# Create test user
RUN curl -X POST 'http://localhost:8086/db/site_dev/users?u=root&p=root' -d '{"name": "test", "password": "test"}'

# Create grafana db
RUN curl -X POST 'http://localhost:8086/db?u=root&p=root' -d '{"name": "grafana"}

# Create metrics db
RUN curl -X POST 'http://localhost:8086/db?u=root&p=root' -d '{"name": "metrics"}

# Install httpd to serve grafana
RUN yum -y install httpd

# Install grafana
RUN mkdir -p /apps/grafana 
RUN cd /apps/grafana && wget http://grafanarel.s3.amazonaws.com/grafana-1.9.0.tar.gz 
RUN ls -la /apps/grafana
RUN cd /apps/grafana && tar xzvf grafana-1.9.0.tar.gz 
RUN cd /apps/grafana && rm -f grafana-1.9.0.tar.gz
RUN ln -s /apps/grafana/grafana-1.9.0 /apps/grafana/default
RUN cat /etc/httpd/conf/httpd.conf
ADD httpd/grafana.conf /etc/httpd/conf.d/grafana.conf

# Start the influxdb daemon
RUN /etc/init.d/influxdb start

# Start httpd
RUN service httpd start

# http port
EXPOSE 80

# Influxdb ports
EXPOSE 8083
EXPOSE 8086
EXPOSE 8090
EXPOSE 8099

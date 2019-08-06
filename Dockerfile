mkdir -p nginx && cd nginx
cat << EOF > dockerfile
FROM phusion/baseimage:0.9.22
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get clean
## Configure nginx ###
ADD     docker/nginx/nginx.conf /etc/nginx/nginx.conf
ADD     docker/nginx/run.sh /etc/service/nginx/run

RUN     pip install --upgrade setuptools
# # Install some python modules
RUN pip install influxdb && \
    pip install xmltodict && \
    pip install pexpect && \
    easy_install pysnmp && \
    pip install lxml && \
    pip install python-crontab && \
    pip install pytest && \
    pip install mock && \
    pip install cryptography==2.1.2 && \
    pip install junos-eznc==2.1.7 && \
    pip install enum

RUN  chmod +x /etc/service/nginx/run        
WORKDIR /
ENV HOME /root

EOF
docker build -t nginx .
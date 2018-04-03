FROM local/c7-systemd

MAINTAINER Michael Snow <sno.sno@gmail.com>

COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 3.8.0

# The font file is used for the generated images
RUN yum update -y && \
    yum install -y rsync wget initscripts libusb pyusb MySQL-python rsyslog && \
    /tmp/setup/setup.sh && \
    yum clean all && \
    rm -rf rm -rf /var/cache/yum/* && \
    rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/www/html/weewx

VOLUME ["/etc/weewx"]
VOLUME ["/var/lib/weewx"]
VOLUME ["/var/www/html/weewx"]
CMD ["/usr/sbin/init"]


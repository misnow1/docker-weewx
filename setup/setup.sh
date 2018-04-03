#!/bin/bash

set -e
set -x

cd /tmp/setup
wget "http://www.weewx.com/downloads/released_versions/weewx-${WEEWX_VERSION}-1.rhel.noarch.rpm"
sha256sum -c < sums
yum install -y weewx-${WEEWX_VERSION}-1.rhel.noarch.rpm
cat > /etc/rsyslog.d/weewx.conf <<EOF
:programname,isequal,"weewx" /var/lib/weewx/weewx.log
:programname,isequal,"weewx" ~
:programname,startswith,"wee_" /var/lib/weewx/weewx.log
:programname,startswith,"wee_" ~

#if $programname == 'weewx' then /var/lib/weewx/weewx.log
#if $programname == 'weewx' then ~
EOF

cat > /etc/logrotate.d/weewx <<EOF
/var/lib/weewx/weewx.log {
  weekly
  missingok
  rotate 4
  compress
  delaycompress
  notifempty
  sharedscripts
  postrotate
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  endscript
}
EOF

sed 's/#compress/compress/' -i /etc/logrotate.conf
rm "weewx-${WEEWX_VERSION}-1.rhel.noarch.rpm"


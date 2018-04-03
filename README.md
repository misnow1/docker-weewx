# weewx for Docker

This Docker image provides support for [WeeWX](http://www.weewx.com/).
Weewx is a simple, easy to use weather station.  It provides
a seamless upgrade from wview as well, so this is an easily-used
replacement for it.

WeeWX will require customization, so please consult the
instructions before beginning.

Some uses (such as with specialized hardware) may require
Docker to run in privileged mode; such cases are beyond the scope
of this manual.  However, serial devices can easily be used
on the host and presented to the Docker container via ser2net.
An increasing number of weather stations are network-enabled and
can communicate directly to this system.

You can view the [documentation for this image](https://github.com/misnow1/docker-weewx)
on its Github page.  This image is based on the [c7-systemd image](https://hub.docker.com/_/centos/).
In order to use this container, you must first build the c7-systemd image as indicated in the
previous link.

This image uses systemd as described in the previous link and requires `CAP_SYS_ADMIN` and
`/sys/fs/cgroups` to be mounted in the running container. Additionally, for USB stations to work,
the USB device tree must be presented to the container and the container must be running in
privileged mode (TODO: fix this).

This image provides the MySQL library for python so that a MySQL database can be used for
persistent data.

You can download with:

    docker pull misnow1/weewx

Then create the container:

    docker create -it --cap-add SYS_ADMIN --tmpfs /run \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v /opt/docker/volumes/weewx/conf:/etc/weewx:rw \
    -v /opt/docker/volumes/weewx/lib:/var/lib/weewx:rw \
    -v /home/weewx/public_html:/home/weewx/public_html:rw \
    -v /etc/localtime:/etc/localtime:ro \
    -v /dev/bus/usb:/dev/bus/usb --privileged \
    --name weewx misnow1/docker-weewx

And start it:

    docker start weewx

Consult the [WeeWX documentation](http://www.weewx.com/docs.html) for setup steps.

# Logging

The container includes rsyslog and sends all weewx logs to /var/lib/weewx by default.

# Source

This is prepared by Michael Snow and the source
can be found at <https://github.com/misnow1/docker-weewx>

# Security Status

TODO: Document this.

# Copyright

The work in this repository is forked from <https://github.com/jgoerzen/docker-weewx>.
Docker scripts, etc. are Copyright (c) 2017 John Goerzen.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of the University nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

Additional software copyrights as noted.

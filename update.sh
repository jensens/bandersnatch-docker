#!/bin/sh
/usr/local/bin/bandersnatch -c /etc/bandersnatch/mirror.conf mirror |& /usr/bin/logger -t bandersnatch[mirror]

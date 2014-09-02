FROM ubuntu:14.04

RUN mkdir -p /apps/log

# Add VOLUMEs to allow backup of logs and a shared gem repository
VOLUME  ["/apps/log", "/gems"]

CMD /bin/bash

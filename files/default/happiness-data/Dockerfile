FROM ubuntu:14.04

RUN mkdir /apps
RUN mkdir /apps/log

# Add VOLUMEs to allow backup of logs and a shared gem repository
VOLUME  ["/apps/log", "/gems"]

CMD /bin/bash

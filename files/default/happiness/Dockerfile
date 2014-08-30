FROM austenito/ruby:2.1.2

ADD run.sh /tmp/happiness/run.sh
RUN chmod +x /tmp/happiness/run.sh

RUN mkdir -p /apps
RUN mkdir -p /apps/log

VOLUME ["/apps/log"]

CMD /tmp/happiness/run.sh

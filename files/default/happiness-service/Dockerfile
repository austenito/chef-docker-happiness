FROM austenito/ruby:2.1.2

ADD run.sh /tmp/happiness-service/run.sh
RUN chmod +x /tmp/happiness-service/run.sh

RUN mkdir -p /apps
RUN mkdir -p /apps/log

VOLUME ["/apps/log"]

CMD /tmp/happiness-service/run.sh

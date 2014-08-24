FROM austenito/ruby:2.1.2

ADD run.sh /tmp/happiness-service/run.sh
RUN chmod +x /tmp/happiness-service/run.sh

RUN mkdir -p /apps

VOLUME ["/apps/log/happiness-service"]

CMD /tmp/happiness-service/run.sh

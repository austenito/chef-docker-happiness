FROM austenito/ruby:2.1.2

ADD run.sh /tmp/happiness-service/run.sh
ADD console.sh /tmp/happiness-service/console.sh
RUN chmod +x /tmp/happiness-service/run.sh
RUN chmod +x /tmp/happiness-service/console.sh

RUN mkdir -p /apps

CMD /tmp/happiness-service/run.sh

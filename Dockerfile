FROM docker.elastic.co/logstash/logstash:7.17.3

USER root

RUN apt-get update && apt-get install rubygems -y

ADD . /logstash-output-cloudwatchlogs
WORKDIR /logstash-output-cloudwatchlogs

RUN gem build logstash-output-cloudwatchlogs.gemspec

WORKDIR /usr/share/logstash
RUN echo 'gem "logstash-output-cloudwatchlogs", :path => "/logstash-output-cloudwatchlogs"' >> Gemfile

RUN logstash-plugin install --no-verify

USER logstash


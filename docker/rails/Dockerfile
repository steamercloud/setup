FROM oneops/centos7

RUN yum -y install graphviz
RUN gem install rails --no-rdoc --no-ri
COPY display.ini /etc/supervisord.d/display.ini
COPY display.sh /opt/display.sh

ENV OO_HOME /home/oneops
ENV RAILS_ENV=development
ENV OODB_USERNAME=kloopz
ENV OODB_PASSWORD=kloopz
EXPOSE 3000

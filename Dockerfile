FROM ubuntu:16.04

LABEL MAINTAINER="Alencar Junior <junior.holowka@gmail.com>"

RUN apt-get update -q && apt-get install -y apt-transport-https ca-certificates

RUN echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list 
RUN echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    apt-get update -q &&\
    apt-get install -y locales &&\
        locale-gen en_US en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    DEBIAN_FRONTEND=noninteractive apt-get update -q &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y pritunl mongodb-org &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y iptables &&\
    apt-get clean &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    rm -rf /tmp/*

COPY limits.conf /etc/security/limits.conf

ADD start-pritunl /bin/start-pritunl

EXPOSE 80
EXPOSE 443
EXPOSE 9700
EXPOSE 1194
EXPOSE 1195

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]


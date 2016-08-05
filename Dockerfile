FROM docbill/fedora-eclipse
MAINTAINER Bill C Riemers https://github.com/docbill

RUN sed -i -e 's,1024m,2048m,g' /etc/eclipse.ini

ADD opt/eclipse.home /opt/eclipse.home


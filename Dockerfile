FROM docbill/ubuntu-umake-eclipse:14.04
MAINTAINER Bill C Riemers https://github.com/docbill

RUN sed -i -e 's,1024m,2048m,g' -e 's,256m,512m,g' /opt/eclipse/eclipse.ini

ADD opt/eclipse.home /opt/eclipse.home


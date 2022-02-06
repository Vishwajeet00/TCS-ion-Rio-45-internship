#Base OS
FROM ubuntu

#Install utilites
RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get -y install vim && \
    apt-get -y install git;

#Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

#Setup JAVA_HOME -- env. variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

#Set up Eclipse IDE
RUN wget http://mirror.tspu.ru/eclipse/technology/epp/downloads/release/2020-06/R/eclipse-jee-2020-06-R-linux-gtk-x86_64.tar.gz -P /opt
RUN cd /opt && tar xvzf eclipse-jee-2020-06-R-linux-gtk-x86_64.tar.gz

#Install and Ccnfigure Apache Tomcat
RUN mkdir /usr/local/tomcat
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.16/* /usr/local/tomcat/
EXPOSE 8080 80
CMD /usr/local/tomcat/bin/catalina.sh run


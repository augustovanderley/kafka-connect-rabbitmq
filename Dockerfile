FROM confluentinc/cp-kafka-connect-base:6.0.0

WORKDIR /app
USER root

RUN yum install which -y
RUN wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar xzvf apache-maven-3.6.3-bin.tar.gz && rm apache-maven-3.6.3-bin.tar.gz
ENV PATH="/app/apache-maven-3.6.3/bin:${PATH}"
ENV JAVA_HOME="/usr/lib/jvm/zulu11"

ADD . /app

RUN mvn clean package
RUN mkdir plugin_jars && \
        mv target/kafka-connect-target/usr/share/kafka-connect/kafka-connect-rabbitmq \
        plugin_jars/

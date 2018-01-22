FROM tomcat:7
ENV TOM=/usr/local/tomcat/bin
ENV APPLE=/usr/local/src/treebase-artifact/mesquite/apple
ENV JAVA_OPTS="-Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties \
    -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
    -Djava.awt.headless=true -Xmx512m -XX:+UseConcMarkSweepGC \
    -Djava.endorsed.dirs=/usr/local/tomcat/endorsed \
    -classpath $TOM/bootstrap.jar:$TOM/tomcat-juli.jar:$APPLE/MRJToolkit.jar:$APPLE/ui.jar \
    -Djava.io.tmpdir=/tmp/tomcat7-tomcat7-tmp \
    -Dorg.apache.el.parser.SKIP_IDENTIFIER_CHECK=true \
    org.apache.catalina.startup.Bootstrap start"

# Pick up some treebase dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        curl \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python


# Tomcat
EXPOSE 8080

WORKDIR "/usr/local/tomcat"

RUN cd /usr/local/src && \
    git clone https://github.com/naturalis/treebase-artifact

RUN unzip /usr/local/src/treebase-artifact/treebase-web.war -d /usr/local/tomcat/webapps/treebase-web/ && \
    unzip /usr/local/src/treebase-artifact/data_provider_web.war -d /usr/local/tomcat/webapps/data_provider_web/ && \
    cd /usr/local/tomcat/lib && wget https://jdbc.postgresql.org/download/postgresql-42.1.4.jre7.jar

COPY context.xml /usr/local/tomcat/webapps/treebase-web/META-INF


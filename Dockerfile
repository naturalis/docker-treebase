FROM tomcat:7
ENV TOM=/usr/local/tomcat/bin
ENV APPLE=/usr/local/src/treebase-artifact/mesquite/apple
ENV CATALINA_OPTS="-Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties \
    -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
    -Djava.awt.headless=true -Xmx8096m -Xms2048m -XX:+UseConcMarkSweepGC \
    -Djava.endorsed.dirs=/usr/local/tomcat/endorsed \
    -classpath $TOM/bootstrap.jar:$TOM/tomcat-juli.jar:$APPLE/MRJToolkit.jar:$APPLE/ui.jar \
    -Djava.io.tmpdir=/tmp/tomcat7-tomcat7-tmp \
    -Dorg.apache.el.parser.SKIP_IDENTIFIER_CHECK=true"
ENV POSTGRES_HOST=db
ENV POSTGRES_DB=treebasedb
ENV POSTGRES_USER=treebase_app
ENV POSTGRES_PASSWORD=PASSWORD

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

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz && \
    tar xzvf docker-17.04.0-ce.tgz && \
    mv docker/docker /usr/local/bin && \
    rm -r docker docker-17.04.0-ce.tgz

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

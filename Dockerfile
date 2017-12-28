FROM tomcat:7

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

WORKDIR "/data"

RUN cd /usr/local/src && \
    git clone https://github.com/naturalis/treebase-artifact

RUN unzip /usr/local/src/treebase-artifact/treebase-web.war -d /usr/local/tomcat/webapps/treebase-web/ && \
    unzip /usr/local/src/treebase-artifact/data_provider_web.war -d /usr/local/tomcat/webapps/data_provider_web/ && \
    cd /usr/local/tomcat/lib && wget https://jdbc.postgresql.org/download/postgresql-42.1.4.jre7.jar

COPY context.xml /usr/local/tomcat/webapps/treebase-web/META-INF



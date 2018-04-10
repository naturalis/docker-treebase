#!/bin/bash

# edit config
/bin/sed -i -E "s/url=\"jdbc:postgresql:.*/url=\"jdbc:postgresql:\/\/$POSTGRES_HOST\/$POSTGRES_DB\"/" /usr/local/tomcat/webapps/treebase-web/META-INF/context.xml
/bin/sed -i -E "s/username=\".*/username=\"$POSTGRES_USER\" password=\"$POSTGRES_PASSWORD\"/" /usr/local/tomcat/webapps/treebase-web/META-INF/context.xml
/bin/sed -i -E "s/Environment name=\"tb2\/SiteUrl\".*/Environment name=\"tb2\/SiteUrl\" value=\"http:\/\/$siteUrl\/treebase-web\/\"/" /usr/local/tomcat/webapps/treebase-web/META-INF/context.xml
/bin/sed -i -E "s/Environment name=\"tb2\/SmtpHost\".*/Environment name=\"tb2\/SmtpHost\" value=\"$SMTPHOST\"/" /usr/local/tomcat/webapps/treebase-web/META-INF/context.xml
# run server
$CATALINA_HOME/bin/catalina.sh run



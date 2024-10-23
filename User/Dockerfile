FROM tomcat:9.0.80-jre8-temurin-jammy
RUN rm -rf /usr/local/tomcat/webapps/ROOT
ADD /target/Crushh-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


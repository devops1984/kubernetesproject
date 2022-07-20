FROM tomcat:latest
USER root
ADD ./webapp/target/webapp.war /usr/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]

FROM tomcat:latest

COPY ./*.war /usr/local/tomcat/webapps

EXPOSE 8080

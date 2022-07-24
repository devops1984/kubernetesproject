FROM tomcat:latest

COPY **/*.war /usr/local/tomcat/webapps
RUN sed -i -e 's/\r$/\n/' */deploy.sh
EXPOSE 8080

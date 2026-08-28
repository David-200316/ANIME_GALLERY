FROM tomcat:9.0-jdk17-openjdk

# Elimina las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

# Copia la carpeta web nativa de NetBeans a Tomcat
COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
FROM tomcat:9.0-jdk17-openjdk

# Limpia la carpeta por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

# Copia todo el contenido de tu carpeta web (Web Pages)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
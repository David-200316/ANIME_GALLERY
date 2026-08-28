
# Servidor Tomcat ligero
FROM tomcat:9.0-jdk17-openjdk

# Elimina la app por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

# Copia los archivos de Web Pages a la raíz del servidor
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
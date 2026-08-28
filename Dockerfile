FROM tomcat:9.0-jdk17-openjdk

# Limpia el directorio por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

# Copia directamente tu archivo JSP (se renombrará a index.jsp) y la carpeta de imágenes
COPY INDEX.jsp /usr/local/tomcat/webapps/ROOT/index.jsp
COPY FOTOS/ /usr/local/tomcat/webapps/ROOT/FOTOS/

EXPOSE 8080

CMD ["catalina.sh", "run"]
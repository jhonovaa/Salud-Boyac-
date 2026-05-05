# 1. Usa una imagen oficial de Tomcat con Java (puedes ajustar la versión de Java si usas otra)
FROM tomcat:9.0-jdk17

# 2. Borra las aplicaciones por defecto de Tomcat (opcional, pero recomendado para evitar conflictos)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 3. Copia tu archivo compilado (.war) a la carpeta de Tomcat
# OJO: Debes reemplazar "Salud-Boyac-1.0.war" por el nombre real del archivo que genera Maven en tu carpeta "target"
COPY target/saludboyaca.war /usr/local/tomcat/webapps/ROOT.war

# 4. Expone el puerto 8080 (el puerto por defecto de Tomcat)
EXPOSE 8080

# 5. Inicia Tomcat
CMD ["catalina.sh", "run"]
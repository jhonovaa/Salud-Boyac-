# 1. Imagen oficial de Tomcat 11 con JDK 21
# Nota: Tomcat 11 requiere Jakarta EE 10, asegurate de que tu proyecto use 'jakarta.*' en lugar de 'javax.*'
FROM tomcat:11.0-jdk21

# 2. Borrar aplicaciones por defecto para evitar conflictos
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 3. Instalar el driver de PostgreSQL (compatible con Supabase)
# El driver 42.7.x es compatible con versiones recientes de Java
ADD https://jdbc.postgresql.org/download/postgresql-42.7.3.jar /usr/local/tomcat/lib/

# 4. Copiar el archivo .war compilado
# IMPORTANTE: Asegurate de que el nombre del archivo en 'target' coincida exactamente
COPY target/saludboyaca.war /usr/local/tomcat/webapps/ROOT.war

# 5. Exponer el puerto
EXPOSE 8080

# 6. Iniciar el servidor
CMD ["catalina.sh", "run"]
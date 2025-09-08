# Base: Tomcat 10 + JDK 17
FROM tomcat:10.1.44-jdk17

# Làm việc trong $CATALINA_HOME để câu lệnh ngắn gọn
WORKDIR /usr/local/tomcat


RUN rm -rf webapps/*


COPY web/ webapps/ROOT/


COPY src/java/ /opt/src/

RUN find /opt/src -name "*.java" > /tmp/sources.txt && \
    javac --release 17 -encoding UTF-8 \
      -cp lib/servlet-api.jar \
      -d webapps/ROOT/WEB-INF/classes \
      @/tmp/sources.txt


CMD bash -lc "sed -ri 's/port=\"8080\"/port=\"'\"$PORT\"'\"/' conf/server.xml && catalina.sh run"

EXPOSE 8080

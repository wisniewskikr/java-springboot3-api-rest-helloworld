FROM maven:3.9.6-eclipse-temurin-21 AS builder
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.skip

FROM eclipse-temurin:21-jre
COPY --from=builder /home/app/target/*.jar  /opt/app/*.jar
ENTRYPOINT ["java", "-jar", "/opt/app/*.jar"]
FROM --platform=$BUILDPLATFORM docker.io/library/maven:3.8.5-eclipse-temurin-17 AS builder
 
WORKDIR /workdir/server
 
COPY pom.xml .
 
RUN mvn dependency:go-offline
 
COPY src ./src
 
RUN mvn clean package -DskipTests
 
 
FROM builder AS prepare-production
 
RUN mkdir -p /workdir/server/target/dependency
 
WORKDIR /workdir/server/target/dependency
 
RUN jar -xf ../*.jar
 
 
FROM docker.io/library/eclipse-temurin:17-jre-focal
 
WORKDIR /app
 
EXPOSE 8080
 
VOLUME /tmp
 
ARG DEPENDENCY=/workdir/server/target/dependency
 
COPY --from=prepare-production ${DEPENDENCY}/BOOT-INF/lib ./lib

COPY --from=prepare-production ${DEPENDENCY}/BOOT-INF/classes ./

COPY --from=prepare-production ${DEPENDENCY}/META-INF ./META-INF
 
ENTRYPOINT ["java", "-cp", ".:lib/*", "com.company.project.Application"]
 

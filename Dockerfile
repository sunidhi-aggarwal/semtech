# Build stage using Maven with JDK 17
FROM maven:3.8.6-eclipse-temurin-17 AS BUILD
COPY . /src
WORKDIR /src
RUN mvn install -DskipTests

# Runtime stage with OpenJDK 17 JRE
FROM eclipse-temurin:17-jre
EXPOSE 8080
WORKDIR /app
ARG JAR=semtech-0.0.1-SNAPSHOT.jar
COPY --from=BUILD /src/target/${JAR} /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
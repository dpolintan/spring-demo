# syntax=docker/dockerfile:1

FROM gradle:8.8-jdk25 AS build
WORKDIR /workspace
COPY build.gradle settings.gradle gradlew gradlew.bat /workspace/
COPY gradle /workspace/gradle
COPY src /workspace/src
RUN ./gradlew bootJar --no-daemon

FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=build /workspace/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]

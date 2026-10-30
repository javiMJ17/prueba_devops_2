
# Etapa 1: Compilar el microservicio
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn -B -ntp dependency:go-offline

COPY src ./src

RUN mvn -B -ntp clean package

# Etapa 2: Ejecutar el microservicio
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 9004

USER 10001

ENTRYPOINT ["java", "-jar", "app.jar"]

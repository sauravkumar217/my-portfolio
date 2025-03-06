FROM maven:3.9.9-amazoncorretto-21-al2023 AS build

WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use OpenJDK 21 to run the application
FROM amazoncorretto:21-al2023

WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/splitify-backend-0.0.1.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
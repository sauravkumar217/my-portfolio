# Use Maven with Amazon Corretto JDK 21
FROM maven:3.9.9-amazoncorretto-21-al2023 AS build

WORKDIR /app

# Copy only pom.xml first and download dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire source code
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Use Amazon Corretto 21 for running the app
FROM amazoncorretto:21-al2023

WORKDIR /app

# Copy the JAR file from the build stage (use wildcard to avoid hardcoded names)
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

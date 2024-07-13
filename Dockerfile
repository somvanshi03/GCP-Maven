# Use an official Maven image to build the project
FROM maven:3.8.4-jdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# Use an official Java runtime image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/messageUtil-1.0.jar /messageUtil-1.0.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app/messageUtil-1.0.jar"]

EXPOSE 8080
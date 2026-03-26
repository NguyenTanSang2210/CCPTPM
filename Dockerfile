FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Sửa từ 8080 thành 80
EXPOSE 80 
# Thêm tham số để Spring Boot chạy trên cổng 80
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=80"]
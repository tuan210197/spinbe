# Giai đoạn build
FROM openjdk:17-slim AS build

# Cài đặt Maven
ENV MAVEN_VERSION=3.8.6
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && wget -q https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
    && rm apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy các file cấu hình và mã nguồn
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ src/
RUN mvn clean package -DskipTests

# Giai đoạn runtime
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy file JAR từ giai đoạn build
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
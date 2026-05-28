# 1단계: 빌드 환경 설정 (Maven + Java 21)
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . /home/src
WORKDIR /home/src
RUN mvn clean package -DskipTests

# 2단계: 실행 환경 설정 (WAR 패키징 실행 환경)
FROM eclipse-temurin:21-jre-jammy
EXPOSE 8080
# pom.xml의 artifactId와 version에 맞게 정확한 war 파일명을 지정합니다.
COPY --from=build /home/src/target/haagendazo-0.0.1-SNAPSHOT.war app.war
ENTRYPOINT ["java", "-jar", "/app.war"]
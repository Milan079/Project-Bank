#-----------------------------------Stage 1----------------------
#pull base image so that we can use,aven to build jar files
FROM maven:3.8.3-openjdk-17 AS builder

#working directory where your code and jar  file will be stored 
WORKDIR /app

# copying all the code from host to container
COPY . /app

#build the app to  generate jar file 
RUN mvn clean install -DskipTests=true

#--------------------------------Stage 2---------------------------------------

FROM openjdk:17-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

#expose the port so that  port can be mapped with the host
EXPOSE 8080

#execute the jar file using the command and -jar flag (to specify we are executing  a jar file)
ENTRYPOINT ["java","-jar","/app/target/bankapp.jar"]

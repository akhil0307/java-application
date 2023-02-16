FROM openjdk:8
ADD jarstaging/com/stalin/java-code/5.0.5/java-code-5.0.5.jar java-code.jar
ENTRYPOINT ["java", "-jar", "java-code.jar"]

# Cheatsheet for azure deployment

```bash
# config dependencies
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.5.0:config
# build, such as
mvn clean install #-DskipTests
mvn clean package spring-boot:repackage  azure-webapp:deploy #-DskipTests -Pboot
# deploy
mvn azure-webapp:deploy
```

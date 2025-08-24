FROM maven:3 AS maven
RUN mvn dependency:get -Dartifact=org.postgresql:postgresql:42.7.7
RUN mvn dependency:get -Dartifact=com.mysql:mysql-connector-j:9.4.0

FROM apache/hive:4.0.1
COPY --from=maven /root/.m2/repository/org/postgresql/postgresql/42.7.7/postgresql-42.7.7.jar $HIVE_HOME/jdbc/postgres.jar
COPY --from=maven /root/.m2/repository/com/mysql/mysql-connector-j/9.4.0/mysql-connector-j-9.4.0.jar $HIVE_HOME/jdbc/mariadb.jar
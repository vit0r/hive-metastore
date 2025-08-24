FROM maven:3 AS maven
RUN mvn dependency:get -Dartifact=org.postgresql:postgresql:42.7.7
RUN mvn dependency:get -Dartifact=com.mysql:mysql-connector-j:9.4.0
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-aws:3.4.1
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-common:3.4.1
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk-core:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk-s3:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk:1.12.788

FROM apache/hive:4.0.1
COPY --from=maven /root/.m2/repository/ $HIVE_HOME/lib/repository
RUN rm -f /opt/hadoop/share/hadoop/common/lib/slf4j-reload4j-1.7.36.jar
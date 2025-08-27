FROM maven:3 AS maven
RUN mvn dependency:get -Dartifact=org.postgresql:postgresql:42.7.7
RUN mvn dependency:get -Dartifact=com.mysql:mysql-connector-j:9.4.0
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-aws:3.3.6
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-common:3.3.6
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-client-api:3.3.6
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-hdfs:3.3.6
RUN mvn dependency:get -Dartifact=org.apache.hadoop:hadoop-mapreduce-client-core:3.3.6
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk-core:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk-s3:1.12.788
RUN mvn dependency:get -Dartifact=com.amazonaws:aws-java-sdk:1.12.788

FROM apache/hive:4.0.1
USER root
RUN mkdir -p $HIVE_HOME/jars/
COPY --from=maven /root/.m2/repository $HIVE_HOME/jars
RUN find jars/ -name "*.jar" -print0 | xargs -0 cp -t lib
RUN rm -rf $HIVE_HOME/jars
RUN rm -f /opt/hadoop/share/hadoop/common/lib/slf4j-reload4j-1.7.36.jar
USER hive

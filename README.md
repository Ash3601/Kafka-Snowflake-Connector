# Kafka-Snowflake-Connector
Contains steps for Kafka to Snowflake connector

# Kafka Snowflake Integration:
--------------------------------------------------------
Download the required jar file -- https://mvnrepository.com/artifact/com.snowflake/snowflake-kafka-connector/1.5.0

Put this jar in libs folders

Update the plugin.path in kafka connect-standalone properties.

# Create Private & Public key-pair:
--------------------------------------------------------------
openssl genrsa -out rsa_key.pem 2048
openssl rsa -in rsa_key.pem -pubout -out rsa_key.pub


# Configure the public key in Snowflake:
----------------------------------------------------------------

alter user {User_name} set rsa_public_key='{Put the Public key content here}';

Verify the public key is configured properly or not --
desc user {User_name};



# Create a SF_connect.properties file with below properties in config folder --
connector.class=com.snowflake.kafka.connector.SnowflakeSinkConnector
tasks.max=8
topics={topic_name}
snowflake.topic2table.map={topic_name}:{snowflake_table_name}
buffer.count.records=10000
buffer.flush.time=60
buffer.size.bytes=5000000
snowflake.url.name={Snowflake URL}
snowflake.user.name={Snowflake User Name}
snowflake.private.key={Put the Private key content here}
snowflake.database.name={Snowflake Database Name}
snowflake.schema.name={Snowflake Schema Name}
key.converter=com.snowflake.kafka.connector.records.SnowflakeJsonConverter
value.converter=com.snowflake.kafka.connector.records.SnowflakeJsonConverter
name={}

# Start zookeeper
./zookeeper-server-start.sh ../config/zookeeper.properties

# Start Kafka Server
./kafka-server-start.sh ../config/server.properties

# Create the topic if not already exists & run the python code to ingest the data in the topic.
$KAFKA_HOME/bin/kafka-topics.sh --create --topic snowflake_test_topic --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1

# Create Consumer
$KAFKA_HOME/bin/kafka-console-consumer.sh --topic snowflake_test_topic  --from-beginning --bootstrap-server localhost:9092

# Create Producer
$KAFKA_HOME/bin/kafka-console-producer.sh --topic snowflake_test_topic  --bootstrap-server localhost:9092


Start the Kafka Connector:
---------------------------------------------------------
./bin/connect-standalone.sh ./config/connect-standalone.properties ./config/SF_connect.properties

To unset the Public Key in Snowflake:
----------------------------------------------------------------------
alter user {User_name} unset rsa_public_key;

# Clean already available data from the topic
# Zookeeper
rm -r /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_logs/zookeeper/*
rm -r /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_logs/server_logs/*


# Start Zookeeper
osascript -e 'tell application "Terminal" to do script "cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_2.12-3.4.0/bin; ./zookeeper-server-start.sh ../config/zookeeper.properties"'


# Start server
osascript -e 'tell application "Terminal" to do script "cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_2.12-3.4.0/bin; ./kafka-server-start.sh ../config/server.properties"'


# Start producer
osascript -e 'tell application "Terminal" to do script "cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_2.12-3.4.0/bin; ./kafka-console-producer.sh --topic snowflake_test_topic  --bootstrap-server localhost:9092"'


# Start consumer
osascript -e 'tell application "Terminal" to do script "cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/kafka_2.12-3.4.0/bin; ./kafka-console-consumer.sh --topic snowflake_test_topic  --from-beginning --bootstrap-server localhost:9092"'

# Start Programmed Producer
# osascript -e 'tell application "Terminal" to do script "cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/; source env/bin/activate;cd /Users/ashina/Library/CloudStorage/OneDrive-AMDOCS/Tasks/KafkaSetup/code; python producer.py"'



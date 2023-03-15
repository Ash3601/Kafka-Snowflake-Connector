from time import sleep
from json import dumps
from kafka import KafkaProducer
import json

topic_name='snowflake_test_topic'
producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))


def load_json(filepath):
    f = open(filepath)
    data = json.load(f)
    products = []
    for i in data['products']:
        products.append(i)
    return products

for e in range(40, 1000):
#     data = {
#   "id": 103715133,
#   "entity_id": 513716692,
#   "description": "Legal Access Plan",
#   "active": 1,
#   "prenotify_days": None,
#   "end_of_life": None,
#   "sku_id": 613300747,
#   "start_of_life": None,
#   "commitment_start_offset": "INTERVAL '0' MONTH",
#   "commitment_end_offset": "INTERVAL '0' MONTH",
#   "default_billing_plan_id": None,
#   "billing_identifier_id": None,
#   "tax_classification_id": None,
#   "credit_id": None,
#   "merchant_id": 101435454,
#   "default_rate_plan_id": None,
#   "category_id": None,
#   "last_modified_ts": "2019-02-08T14:12:42.841Z",
#   "_topic": "vproduct",
#   "_source": "pgprodtestdb1"
# }
#     print(data)
    filepath = "../dummy_product.json"
    data_load = load_json(filepath)
    for data in data_load:
      print (data)
      producer.send(topic_name, value=data)
    sleep(5)
    exit()
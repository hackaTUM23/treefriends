import logging
import os
import paho.mqtt.client as mqtt
from Datamodel.Request import Request
from Datamodel.Tree import Tree
from TreeWatcher import TreeWatcher
from database import Database
from dotenv import load_dotenv
from services.poi_service import WaterSourceService

class MQTTConnection:
    _broker: str
    _port: int
    _client: mqtt.Client
    _database: Database

    def __init__(self, broker, port=1883, database=None):
        load_dotenv()
        self._broker = broker
        self._port = port
        self._client = mqtt.Client()
        self._database = database
        water_source_data = os.getenv('WATER_SOURCE_DATA')
        self._water_source_service = WaterSourceService(water_source_data)       
 
        # Set up callbacks
        self._client.on_connect = self.on_connect
        self._client.on_message = self.on_message

    def connect(self):
        self._client.connect(self._broker, self._port, 60)

    def on_connect(self, client, userdata, flags, rc):
        logging.debug(f"Connected with result code {rc}")

    def on_message(self, client, userdata, msg):
        logging.debug(f"Received message: {msg.payload} on topic: {msg.topic}")
        topic_parts = msg.topic.split("/")

        # TODO: Switch on topic 
        if topic_parts[1] == "sensor":
            self.handle_sensor_data(topic_parts[2], msg)
        elif topic_parts[1] == "request":
            self.handle_request(msg)

    def publish(self, topic, message):
        self._client.publish(topic, message)

    def subscribe_to_topic(self, topic):
        self._client.subscribe(topic)

    def start(self):
        self._client.loop_start()

    def stop(self):
        self._client.loop_stop()

    def handle_sensor_data(self, topic, msg):
        logging.debug(f"Handling sensor data with topic: {topic} and message: {msg.payload}")
        # Split the topic into parts
        sensor_id = topic.split("_")[0]
        data_type = topic.split("_")[1]

        logging.debug(f"Sensor ID: {sensor_id}, Data type: {data_type}")

        # Find the tree with the matching sensor ID
        tree = self._database.get_tree(sensor_id)

        if tree is not None:
            if data_type == 'moisture':
                tree.moisture = float(msg.payload)
                treeWatcher = TreeWatcher(tree)
                if treeWatcher.is_tree_okay() is False:
                    self.send_new_request(tree)

                self.send_sensor_data(tree)
                
            elif data_type == 'conductivity':
                tree.soil_conductivity = float(msg.payload)

            self._database.add_tree(tree)

        logging.debug(f"Updated sensor data for tree with sensor ID: {sensor_id}")

    def send_new_request(self, tree: Tree):
        water_sources = list(self._water_source_service.get_water_sources(tree.location.longitude, tree.location.latitude))
        request = Request(tree, water_sources=water_sources)
        logging.debug(f"Created new request: {request.to_json()}")
        self._database.add_request(request)

        #topic = os.getenv('MQTT_TOPIC_PREFIX') + "/user1" + "/request"
        topic = "coaty/3/agent/DSC/thing/state"
        self.publish(topic, request.to_json())
        logging.debug(f"Sent out on topic '{topic}' new request {request.to_json()}")

    def send_sensor_data(self, tree: Tree):
        topic = os.getenv('MQTT_TOPIC_PREFIX') + "/sensor/test_moisture" + "/state"
        topic = "coaty/3/agent/DSC/thing/state"
        msg = "{ \"object\": " + tree.to_json() + "}"
        self.publish(topic, msg)
        logging.debug(f"Sent out on topic '{topic}' new sensor data {msg}")

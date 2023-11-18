import logging
import paho.mqtt.client as mqtt
from Datamodel.Tree import Tree

class MQTTConnection:
    def __init__(self, broker, port=1883, database=None):
        self.broker = broker
        self.port = port
        self.client = mqtt.Client()
        self.database = database
        
        # Set up callbacks
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message

    def connect(self):
        self.client.connect(self.broker, self.port, 60)

    def on_connect(self, client, userdata, flags, rc):
        print(f"Connected with result code {rc}")

    def on_message(self, client, userdata, msg):
        logging.debug(f"Received message: {msg.payload} on topic: {msg.topic}")
        topic_parts = msg.topic.split("/")

        # TODO: Switch on topic 
        if topic_parts[1] == "sensor":
            self.handle_sensor_data(topic_parts[2], msg)
        elif topic_parts[1] == "request":
            self.handle_request(msg)


    def subscribe_to_topic(self, topic):
        self.client.subscribe(topic)

    def start(self):
        self.client.loop_start()

    def stop(self):
        self.client.loop_stop()

    def handle_sensor_data(self, topic, msg):
        logging.debug(f"Handling sensor data with topic: {topic} and message: {msg.payload}")
        # Split the topic into parts
        sensor_id = topic.split("_")[0]
        data_type = topic.split("_")[1]

        logging.debug(f"Sensor ID: {sensor_id}, Data type: {data_type}")

        # Find the tree with the matching sensor ID
        tree = self.database.get_tree(sensor_id)

        if tree is not None:
            if data_type == 'moisture':
                tree.moisture = float(msg.payload)
            elif data_type == 'conductivity':
                tree.soil_conductivity = float(msg.payload)

            self.database.add_tree(tree)

        logging.debug(f"Updated sensor data for tree with sensor ID: {sensor_id}")
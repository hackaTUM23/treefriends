import json
import logging
from time import sleep
from Datamodel.Tree import Tree
from MQTTConnection import MQTTConnection
from database import Database

# Set up logging
logging.basicConfig(level=logging.DEBUG)


if __name__ == "__main__":
    database = Database()
    database.add_tree(Tree(id="klmnopqrstuvwxyza", longitude=11.669272, latitude=48.263082, moisture=50.5, soil_conductivity=300))
    database.add_tree(Tree(id="klmnopqrstuvwxyzr", longitude=11.123, latitude=21.456, moisture=51.5, soil_conductivity=301))

    mqtt_connection = MQTTConnection(broker="broker.hivemq.com", database=database)
    mqtt_connection.connect()

    # Subscribe to both moisture and soil_conductivity topics using wildcard
    mqtt_connection.subscribe_to_topic("e75d6d7d31777e47cf22c81c2314b028/sensor/#")

    # Start the MQTT loop
    mqtt_connection.start()

    # Keep the program running
    try:
        while True:
            sleep(1)
    except KeyboardInterrupt:
        print("Interrupted by user. Stopping MQTT connection.")
        mqtt_connection.stop()
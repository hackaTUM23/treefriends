import logging
import os
from time import sleep

from dotenv import load_dotenv
from Datamodel.Location import location
from Datamodel.Tree import Tree
from MQTTConnection import MQTTConnection
from database import Database

# Set up logging
logging.basicConfig(level=logging.DEBUG)


if __name__ == "__main__":
    load_dotenv()
    database = Database()
    database.add_tree(Tree(id="klmnopqrstuvwxyzr", location=location(latitude=48.15669382452469, longitude=11.669272), moisture=50.5, soil_conductivity=300))
    database.add_tree(Tree(id="klmnopqrstuvwxyza", location=location(latitude=48.15669382452469, longitude=11.50255324350659), moisture=51.5, soil_conductivity=301))
            
    mqtt_connection = MQTTConnection(os.getenv('MQTT_BROKER'), database=database)
    mqtt_connection.connect()

    # Subscribe to both moisture and soil_conductivity topics using wildcard
    mqtt_connection.subscribe_to_topic(os.getenv('MQTT_TOPIC_PREFIX') + "/sensor/#")

    # Start the MQTT loop
    mqtt_connection.start()

    # Keep the program running
    try:
        while True:
            sleep(1)
    except KeyboardInterrupt:
        print("Interrupted by user. Stopping MQTT connection.")
        mqtt_connection.stop()
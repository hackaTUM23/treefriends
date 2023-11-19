import logging
import os
from time import sleep

from dotenv import load_dotenv
from Datamodel.Location import location
from Datamodel.Tree import Tree
from MQTTConnection import MQTTConnection
from database import Database
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/trees', methods=['GET'])
def get_trees():
    trees = database.get_all_trees()
    return jsonify(trees), 200

@app.route('/requests', methods=['GET'])
def get_requests():
    requests = database.get_all_requests()
    return jsonify(requests), 200

# Set up logging
logging.basicConfig(level=logging.DEBUG)


if __name__ == "__main__":
    load_dotenv()
    database = Database()
    database.add_tree(Tree(id="klmnopqrstuvwxyzr", location=location(latitude=48.15669382452469, longitude=11.669272), moisture=50.5, soil_conductivity=300))
    database.add_tree(Tree(id="klmnopqrstuvwxyza", location=location(latitude=48.132440, longitude=11.599787), moisture=51.5, soil_conductivity=301))
    database.add_tree(Tree(id="klmnopqrstuvwxyzq", location=location(latitude=48.15669382452469, longitude=11.50255324350659), moisture=51.5, soil_conductivity=301))
            
    mqtt_connection = MQTTConnection(os.getenv('MQTT_BROKER'), database=database)
    mqtt_connection.connect()

    # Subscribe to both moisture and soil_conductivity topics using wildcard
    mqtt_connection.subscribe_to_topic(os.getenv('MQTT_TOPIC_PREFIX') + "/sensor/#")

    # Start the MQTT loop
    mqtt_connection.start()

     # Start the Flask app
    app.run(host='0.0.0.0', port=os.getenv('FLASK_PORT'))

    try:
        while True:
            sleep(1)
    except KeyboardInterrupt:
        print("Interrupted by user. Stopping MQTT connection.")
        mqtt_connection.stop()

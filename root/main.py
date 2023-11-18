from sqlalchemy import create_engine, Column, Integer, Float, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

# Create SQLite database engine (in-memory for this example)
engine = create_engine('sqlite:///:memory:', echo=True)

# Create a base class for declarative class definitions
Base = declarative_base()

# Define 'Sensor' class
class Sensor(Base):
    __tablename__ = 'sensors'

    id = Column(Integer, primary_key=True)
    humidity = Column(Float)
    temperature = Column(Float)
    soil_conductivity = Column(Float)
    illumination = Column(Float)

# Define 'Request' class
class Request(Base):
    __tablename__ = 'requests'

    id = Column(Integer, primary_key=True)
    sensor_id = Column(Integer, ForeignKey('sensors.id'))
    humidity = Column(Float)

    # Define relationship to 'Sensor' table
    sensor = relationship('Sensor', back_populates='requests')

# Establish a relationship from 'Sensor' to 'Request'
Sensor.requests = relationship('Request', order_by=Request.id, back_populates='sensor')

# Create tables in the database
Base.metadata.create_all(engine)

# Create a session to interact with the database
Session = sessionmaker(bind=engine)
session = Session()

print("Tables 'sensors' and 'requests' created successfully using SQLAlchemy.")


# Create some mock data
sensor1 = Sensor(humidity=60.5, temperature=25.0, soil_conductivity=300.0, illumination=1200.0)
sensor2 = Sensor(humidity=55.0, temperature=24.5, soil_conductivity=350.0, illumination=1000.0)
sensor3 = Sensor(humidity=70.2, temperature=26.0, soil_conductivity=280.0, illumination=800.0)
sensor4 = Sensor(humidity=45.8, temperature=23.5, soil_conductivity=400.0, illumination=1500.0)

request1 = Request(sensor_id=1, humidity=65.0)

# Add data to the session
session.add_all([sensor1, sensor2, sensor3, sensor4, request1])
session.commit()

# Query data from the database
print("\nSensor Data:")
for sensor in session.query(Sensor).all():
    print(f"Sensor ID: {sensor.id}, Humidity: {sensor.humidity}, Temperature: {sensor.temperature}, Soil Conductivity: {sensor.soil_conductivity}, Illumination: {sensor.illumination}")

print("\nRequest Data:")
for request in session.query(Request).all():
    print(f"Request ID: {request.id}, Sensor ID: {request.sensor_id}, Humidity: {request.humidity}")

# Close the session
session.close()




class Tree:
    id: int
    longitude: float
    latitude: float
    moisture: float
    soil_conductivity: float

    def __init__(self, id, longitude, latitude, moisture, soil_conductivity) -> None:
        self.id = id
        self.longitude = longitude
        self.latitude = latitude
        self.moisture = moisture
        self.soil_conductivity = soil_conductivity

    def to_dict(self):
        return {
            "id": self.id,
            "longitude": self.longitude,
            "latitude": self.latitude,
            "moisture": self.moisture,
            "soil_conductivity": self.soil_conductivity
        }

    def __str__(self) -> str:
        return f"Tree: id={self.id}, longitude={self.longitude}, latitude={self.latitude}, moisture={self.moisture}, soil_conductivity={self.soil_conductivity}"

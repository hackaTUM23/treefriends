
import json

class location:
    def __init__(self, latitude, longitude):
        self.latitude = latitude
        self.longitude = longitude
        
    def to_dict(self):
        return {
            "latitude": self.latitude,
            "longitude": self.longitude
        }

    def to_json(self):
        return json.dumps(self.to_dict())

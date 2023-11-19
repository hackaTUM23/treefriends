import json
import uuid
from Datamodel.Location import location

class Watersource:
    def __init__(self, location: location) -> None:
        self._id = str(uuid.uuid4())
        self._location = location

    def to_dict(self):
        return {
            "id": self._id,
            "location": self._location.to_dict()
        }
    
    def to_json(self):
        return json.dumps(self.to_dict())

from Datamodel.Location import location

class Tree:

    def __init__(self, id: str, location: location, moisture: int, soil_conductivity: int):
        self.id = id
        self.location = location
        self.moisture = moisture
        self.soil_conductivity = soil_conductivity

    def to_dict(self):
        return {
            "id": self.id,
            "location": self.location.to_dict(),
            "moisture": self.moisture,
            "soil_conductivity": self.soil_conductivity
        }

    def __str__(self) -> str:
        return f"Tree: id={self.id}, location={self.location}, moisture={self.moisture}, soil_conductivity={self.soil_conductivity}"

import json
import uuid


class Request:

    def __init__(self, tree, water_sources: [()]):
        self.id= str(uuid.uuid4()) 
        self.tree = tree
        self.water_sources = water_sources
        self.status = False
        
    def set_completed(self):
        self.status = True

    def to_dict(self):
        return {
            "id": self.id,
            "Tree": self.tree.to_dict(),
            "water_sources": self.water_sources,
            "status": self.status
        }

    def __str__(self) -> str:
        return f"Request: id={self.id}, Tree={self.tree}, water_sources={self.water_sources} status={self.status}"

    def to_json(self):
        return json.dumps(self.to_dict())
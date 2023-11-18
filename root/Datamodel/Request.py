import uuid

class Request:
    id: int
    Tree: Tree
    status: bool

    def __init__(self, Tree) -> None:
        self.id= str(uuid.uuid4()) 
        self.Tree = Tree
        self.status = False
        
    def set_completed(self):
        self.status = True

    def to_dict(self):
        return {
            "id": self.id,
            "Tree": self.Tree.to_dict(),
            "status": self.status
        }

    def __str__(self) -> str:
        return f"Request: id={self.id}, Tree={self.Tree}, status={self.status}"

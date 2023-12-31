import logging

class Database:
    def __init__(self):
        self._trees = {}
        self._requests = {}
        
    def add_tree(self, tree):
        self._trees[tree.id] = tree
        logging.debug(f"Added tree: {tree}")
        
    def get_tree(self, id):
        try:
            return self._trees[id]
        except KeyError:
            return None
    
    def add_request(self, request):
        self._requests[request.id] = request
        logging.debug(f"Added request: {request}")
        
    def get_request(self, id):
        try: 
            return self._requests[id]
        except KeyError:
            return None

    def get_all_trees(self):
        return [tree.to_dict() for tree in self._trees.values()]

    def get_all_requests(self):
        return [request.to_dict() for request in self._requests.values()]

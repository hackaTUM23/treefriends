
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
        self._requests[request.request_id] = request
        logging.debug(f"Added request: {request}")
        
    def get_request(self, request_id):
        try: 
            return self._requests[request_id]
        except KeyError:
            return None

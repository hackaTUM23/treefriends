

class TreeWatcher():
    _tree = None

    def __init__(self, tree):
        self._tree = tree
        
    def is_tree_okay(self):
        if self.moisture_needed():
            return False
        return True

    def moisture_needed(self):
        if int(self._tree.moisture) < 10:
            return True
        else:
            return False

    
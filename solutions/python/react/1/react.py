class InputCell:
    def __init__(self, value):
        self._value = value
        self._observers = []

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, value):
        if self._value != value:
            self._value = value
            # Topological sort of all dependent cells
            observers = self._get_all_observers()
            
            # Keep track of last reported values to ensure change is detected
            # Actually, ComputeCell already stores last_reported_value.
            # We just need to trigger the update and check.
            
            # The key is to propagate updates only IF the value actually changes
            # This is complex because we need to know if the value changed.
            # Let's use a two-pass approach: 1. Update, 2. Notify.
            
            for observer in observers:
                observer.update()
                
            # Trigger callbacks for those that changed
            for observer in observers:
                observer._check_callbacks()

    def _get_all_observers(self):
        observers = {}
        def collect(cell, depth):
            for observer in cell._observers:
                if observer not in observers or observers[observer] < depth:
                    observers[observer] = depth
                    collect(observer, depth + 1)
        collect(self, 1)
        return sorted(observers.keys(), key=lambda x: observers[x])


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self._inputs = inputs
        self._compute_function = compute_function
        self._value = self._compute_function([i.value for i in self._inputs])
        self._callbacks = []
        self._observers = []
        self._last_reported_value = self._value
        
        for input_cell in inputs:
            input_cell._observers.append(self)

    def update(self):
        self._value = self._compute_function([i.value for i in self._inputs])
        
    def _check_callbacks(self):
        # We need to only trigger if the value actually changed.
        # But we also need to store the value as it was before this update, 
        # to compare correctly.
        if self._value != self._last_reported_value:
            for callback in list(self._callbacks):
                if callback in self._callbacks:
                    callback(self._value)
            self._last_reported_value = self._value

    @property
    def value(self):
        return self._value

    def add_callback(self, callback):
        self._callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self._callbacks:
            self._callbacks.remove(callback)
    
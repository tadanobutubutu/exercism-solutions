import io


class MeteredFile(io.BufferedRandom):
    """Implement using a subclassing model."""
    
    def __init__(self, *args, **kwargs):
        # Initialize the parent class with the given arguments
        super().__init__(*args, **kwargs)
        # Initialize counters
        self._read_ops = 0
        self._read_bytes = 0
        self._write_ops = 0
        self._write_bytes = 0

    def __enter__(self):
        # Simply return self, do not call super().__enter__()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        # Delegate to the parent class's __exit__
        return super().__exit__(exc_type, exc_val, exc_tb)

    def __iter__(self):
        # We want to use the underlying file's iterator, but track the operations
        # Actually, file iteration uses readline. 
        # Let's override it to track the calls
        return self

    def __next__(self):
        line = super().readline()
        if line:
            self._read_ops += 1
            self._read_bytes += len(line)
            return line
        raise StopIteration

    def read(self, size=-1):
        # Increment read operation counter
        self._read_ops += 1
        # Read data from the parent class
        data = super().read(size)
        # Update byte counter
        if data:
            self._read_bytes += len(data)
        return data

    @property
    def read_bytes(self):
        return self._read_bytes

    @property
    def read_ops(self):
        return self._read_ops

    def write(self, b):
        # Increment write operation counter
        self._write_ops += 1
        # Write data using the parent class
        bytes_written = super().write(b)
        # Update byte counter
        if bytes_written:
            self._write_bytes += bytes_written
        return bytes_written

    @property
    def write_bytes(self):
        return self._write_bytes

    @property
    def write_ops(self):
        return self._write_ops


class MeteredSocket:
    """Implement using a delegation model."""
    
    def __init__(self, socket):
        self._socket = socket
        # Initialize counters
        self._recv_ops = 0
        self._recv_bytes = 0
        self._send_ops = 0
        self._send_bytes = 0

    def __enter__(self):
        # Context manager entry - return self
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        # Context manager exit - delegate to wrapped socket if it has __exit__
        if hasattr(self._socket, '__exit__'):
            return self._socket.__exit__(exc_type, exc_val, exc_tb)
        return False

    def recv(self, bufsize, flags=0):
        # Increment recv operation counter
        self._recv_ops += 1
        # Receive data from the wrapped socket
        data = self._socket.recv(bufsize, flags)
        # Update byte counter
        if data:
            self._recv_bytes += len(data)
        return data

    @property
    def recv_bytes(self):
        return self._recv_bytes

    @property
    def recv_ops(self):
        return self._recv_ops

    def send(self, data, flags=0):
        # Increment send operation counter
        self._send_ops += 1
        # Send data using the wrapped socket
        bytes_sent = self._socket.send(data, flags)
        # Update byte counter
        if bytes_sent:
            self._send_bytes += bytes_sent
        return bytes_sent

    @property
    def send_bytes(self):
        return self._send_bytes

    @property
    def send_ops(self):
        return self._send_ops

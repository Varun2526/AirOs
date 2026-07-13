import cv2

class Camera:
    def __init__(self, camera_index=0):
        self.camera_index = camera_index
        self.cap = None

    def start(self):
        self.cap = cv2.VideoCapture(self.camera_index)
        if not self.cap.isOpened():
            raise RuntimeError(f"Failed to open camera at index {self.camera_index}")

    def capture_frame(self):
        if self.cap is None or not self.cap.isOpened():
            raise RuntimeError("Camera is not started. Call start() first.")
        ret, frame = self.cap.read()
        if not ret:
            raise RuntimeError("Failed to capture frame")
        return frame

    def release(self):
        if self.cap is not None:
            self.cap.release()
            self.cap = None

    def __enter__(self):
        self.start()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.release()

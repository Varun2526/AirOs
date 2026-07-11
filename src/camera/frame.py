from dataclasses import dataclass
import numpy as np

@dataclass(frozen=True)
class Frame:
    """
    Represents a single raw observation captured from the camera.

    A Frame contains only factual information captured by the Camera
    Capture module. It does not store derived data such as landmarks,
    gestures, confidence scores, or FPS.
    """
    frame_number: int
    timestamp: float
    image: np.ndarray




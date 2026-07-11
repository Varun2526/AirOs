# Engineering Learning Log 01 — Project Setup and Camera Architecture

> **AirOS Engineering Learning Log**
> **Focus:** Environment Setup, Core Python Constructs, and Foundational Module Design

---

## 1. Project Setup and Virtual Environments

### What It Is
A Python virtual environment (`.venv`) is an isolated, self-contained directory tree that contains a Python installation for a particular version of Python, plus a number of additional packages.

### Why It Exists and The Problem It Solves
Python installs packages globally by default. If multiple projects share the global environment, upgrading a dependency (like OpenCV or NumPy) for Project A might silently break Project B, which expects an older version. Virtual environments solve the "dependency hell" problem by isolating project requirements.

### Alternatives
- **Global Installation:** Fast but dangerous, leading to cross-project conflicts.
- **Docker:** Offers complete OS-level isolation, but introduces overhead for simple local development and webcam hardware passthrough issues.
- **Conda:** Heavyweight environments typically used in data science, but overkill for standard software engineering.

### Why AirOS Chose This Approach
We use the standard library `venv` module. It is lightweight, requires no external tools, and guarantees that our production code runs in a perfectly reproducible state. Configuring VS Code to point to the `.venv` interpreter ensures our IDE provides the correct auto-completion and linting based exclusively on our isolated dependencies.

### Trade-offs
Virtual environments consume disk space (each environment duplicates standard binaries), and developers must remember to manually activate them (`source .venv/bin/activate`) before running scripts or installing packages.

### Practical Engineering Takeaways
- **Never install project dependencies globally.**
- Always select the virtual environment interpreter in your IDE before writing code.
- Isolation guarantees reproducibility.

---

## 2. Python REPL (Read-Eval-Print Loop)

### What It Is
The REPL is an interactive programming environment that takes single user inputs, executes them, and returns the result to the user. It is invoked simply by typing `python3` in the terminal.

### Why It Exists and The Problem It Solves
Software engineering requires constant verification of assumptions. Writing a full script to test if a specific function works or what type an object is adds unnecessary friction. The REPL provides immediate feedback.

### The Terminal (zsh) vs. Python REPL
A common error is attempting to execute Python syntax directly in the zsh shell. The shell is an operating system interface designed to run executables (like `ls`, `cd`, `python3`). It does not understand Python syntax. You must start the REPL environment first to evaluate Python code.

### Practical Engineering Takeaways
- **Experiment over guessing.** If you are unsure what type a function returns, do not guess. Open the REPL and run `type(obj)`.
- Use the REPL as an interactive debugger to inspect APIs before committing them to production code.

---

## 3. Packages vs. Flat Structure

### What It Is
A Python package is a directory containing a special `__init__.py` file (even if empty) and other Python modules (`.py` files).

### `__init__.py` vs `__init__()`
- `__init__.py` is a file that tells the Python interpreter that the directory it resides in should be treated as a package.
- `__init__()` is a magic method inside a Python class used to initialize a new instance of that class (the constructor).

### Why Packages Exist and The Problem They Solve
Placing all code inside a single `src/` directory leads to an unmaintainable, flat namespace. Packages solve the problem of organizational scale by grouping related logic into namespaces (e.g., `src.camera`, `src.perception`).

### Why AirOS Chose This Approach
AirOS is a complex system spanning hardware capture, machine learning, and OS interactions. Packages enforce architectural boundaries. The Camera package does not intermingle with the Gesture Engine package, making the codebase navigable and preventing circular dependencies.

### Practical Engineering Takeaways
- **Software architecture determines package structure.**
- Group code by responsibility and domain, not just by file type.

---

## 4. Dataclasses and Immutability

### What It Is
The `@dataclass` decorator (introduced in Python 3.7) automatically generates special methods like `__init__()` and `__repr__()` for classes that primarily store state.

```python
from dataclasses import dataclass
import numpy as np

@dataclass(frozen=True)
class Frame:
    frame_number: int
    timestamp: float
    image: np.ndarray
```

### Why It Exists and The Problem It Solves
Writing boilerplate `__init__` methods for objects that just hold data is tedious and error-prone. Dataclasses automate this.

### Why AirOS Chose This Approach (and `frozen=True`)
The `Frame` object is an observation. Observations are historical facts. By using `frozen=True`, the dataclass enforces **immutability**—once a frame is captured, its timestamp and pixel data cannot be accidentally overwritten by downstream modules.

### Trade-offs
Immutability means you cannot mutate the object in place; if downstream modules need to modify the image (e.g., drawing debug bounding boxes), they must create a new object or a copy, incurring a slight memory cost. In AirOS, this cost is vastly outweighed by the guarantee of data integrity.

### Practical Engineering Takeaways
- Use dataclasses for objects whose primary purpose is holding data.
- Default to `frozen=True` for observations. **Immutability prevents an entire class of state-mutation bugs.**

---

## 5. AirOS Frame Design: Facts vs. Interpretations

### What It Is
The `Frame` object is the foundational data structure of the Camera module. It represents one raw observation.

### Why We Designed Before Implementing
Writing code without defining the data boundaries leads to module coupling. By designing `Frame` first, we rigorously defined the responsibilities of the Camera Capture module before writing any functional logic.

### Principle: Store Facts, Not Interpretations
A fact is something directly observed. An interpretation is something computed.

**Frame contains facts:**
- `frame_number`: Sequential ordering.
- `timestamp`: Temporal position.
- `image`: Raw pixel data.

**Frame intentionally DOES NOT contain:**
- **Landmarks/Gestures:** These are interpretations produced by the Perception and Gesture engines. The Camera knows nothing about hands.
- **Confidence:** A property of the ML model, not the camera sensor.
- **Cursor position:** A downstream OS configuration interpretation.
- **FPS:** (See Topic 6)

### Practical Engineering Takeaways
- Define object boundaries before writing execution logic.
- Keep raw data isolated from processed data.

---

## 6. Frames and FPS (Frames Per Second)

### The Problem
It is tempting to store `fps` on the `Frame` object so downstream consumers know the stream rate.

### Why This is Wrong
FPS is **derived information**, not an observation. A single frame is a snapshot in time; it does not have a "speed". FPS is a calculation of the distance between *multiple* timestamps. If a system stutters, the instantaneous time between two frames might imply 15 FPS, while the overall stream averages 30 FPS. 

### Why AirOS Chose This Approach
By keeping FPS out of the `Frame`, we force downstream modules to calculate velocity or framerates dynamically by comparing sequential frame `timestamps`. This makes the system resilient to jitter and real-world camera performance fluctuations.

### Practical Engineering Takeaways
- Never store aggregate or derived metrics on an atomic observation object.

---

## 7. NumPy in Computer Vision

### What It Is
NumPy is the fundamental package for scientific computing in Python. It provides a high-performance multidimensional array object (`ndarray`).

### Why It Exists and The Problem It Solves
Python lists are extremely slow and memory-inefficient for large mathematical operations. Computer vision requires processing millions of pixels (numbers) per second. NumPy arrays are implemented in C and provide continuous memory blocks, allowing for vectorised operations.

### `np.array` vs `np.ndarray`
- `np.ndarray` is the **actual class** (the type).
- `np.array` is a **factory function** that returns an `np.ndarray` object.

### The Experimental Proof (via REPL)
```python
>>> import numpy as np
>>> type(np.array)
<class 'builtin_function_or_method'>
>>> type(np.ndarray)
<class 'type'>
>>> a = np.array([1, 2, 3])
>>> type(a)
<class 'numpy.ndarray'>
```

### Why Type Hints Use `np.ndarray`
Type hints declare the *class* of the expected object. Because `np.array` is a function, not a type, using it as a type hint is syntactically invalid. The correct type is `np.ndarray`.

### Practical Engineering Takeaways
- Images are just matrices of numbers.
- Always use the actual type (`np.ndarray`) for type hinting, not the constructor function.

---

## 8. Documentation and Docstrings

### What It Is
A docstring is a string literal that occurs as the first statement in a module, function, class, or method definition.

### Why It Exists
It provides live, accessible documentation that IDEs can surface when hovering over code, decoupling the documentation from external markdown files.

### Why AirOS Follows Strict Placement
Docstrings describe the *purpose* and *responsibilities* of a class. They are placed **immediately** after the class declaration, before any fields or methods. They should not blindly repeat the field names (which are self-evident from the code), but rather explain *why* the class exists and how it should be used.

### Practical Engineering Takeaways
- Document the "why" and "what", not the "how" (which the code already shows).
- Strict placement ensures tooling (Sphinx, VS Code) parses the documentation correctly.

---

## 9. Software Engineering vs. Scripting

### The Core Difference
Scripting is writing code to solve a problem once. Software engineering is designing a system to be maintained, extended, and debugged over time by multiple people.

### Key Learnings
- **Design Before Implementation:** Writing code is the final step, not the first step.
- **Reason About Responsibilities:** Instead of asking "how do I open the webcam?", ask "which module should own the webcam lifecycle?".
- **Ownership:** Code is fundamentally about data ownership and hardware resource lifecycle management.

### Practical Engineering Takeaways
- Good software engineering removes responsibilities from modules rather than continuously adding them.

---

## 10. Camera Module Discussion: Class vs. Function

### What It Is
The Camera Capture module will interface with OpenCV to read frames from the hardware webcam.

### Why We Are Using a Class
Hardware resources (like webcams, files, or network sockets) have a lifecycle: they must be initialized (opened), utilized (read), and safely destroyed (released). 

A simple function `read_camera()` cannot safely manage state across multiple calls without relying on dangerous global variables. A class allows us to encapsulate the camera handle (state) and guarantee safe resource cleanup via methods like `start()` and `stop()`.

### Practical Engineering Takeaways
- If a component owns the lifecycle of an external resource or needs to maintain state across time, it should usually be implemented as a class.

---

## Mistakes & Corrections

### 1. Using `np.array` instead of `np.ndarray` as a type hint
- **What I did:** Wrote `image: np.array` in the dataclass definition.
- **Why it was wrong:** `np.array` is a factory function, not a type.
- **How I discovered it:** Corrected by the AI, and subsequently verified the difference in the REPL using the `type()` function.
- **Correct understanding:** Type hints require actual classes. The correct underlying class is `numpy.ndarray`.
- **How to avoid:** Remember that functions create objects, but objects belong to classes. If unsure, use the REPL (`type(obj)`) to verify the class of an object.

### 2. Misplaced Class Docstring
- **What I did:** Placed the triple-quoted docstring *after* the class fields.
- **Why it was wrong:** Python tooling expects the docstring to be the very first statement inside the class block. Placing it after fields makes it a standard string literal that gets ignored by linters and IDEs.
- **How I discovered it:** Corrected during code review.
- **Correct understanding:** Docstrings must immediately follow `class ClassName:`.
- **How to avoid:** Treat docstrings as a structural part of the class declaration, not just as a comment.

### 3. Writing Python syntax in the zsh shell
- **What I did:** Typed Python commands directly into the terminal prompt.
- **Why it was wrong:** The terminal (zsh) is an OS interface. It cannot execute Python syntax directly.
- **How I discovered it:** The shell returned "command not found" errors.
- **Correct understanding:** You must launch the Python interpreter (`python3`) to enter the REPL before writing Python code.
- **How to avoid:** Always look at the prompt symbol. `$` or `%` means shell. `>>>` means Python REPL.

### 4. Confusing `__init__.py` with `__init__()`
- **What I did:** Mixed up the two concepts during discussion.
- **Why it was wrong:** They serve entirely different purposes at different levels of the system.
- **How I discovered it:** Clarified during the package structure discussion.
- **Correct understanding:** `__init__.py` is a filesystem marker indicating a directory is a Python package. `__init__()` is a Python class constructor.
- **How to avoid:** Think of `.py` files as structural markers for the OS/Interpreter, and `()` methods as structural markers for class objects.

### 5. Believing NumPy was mainly for visualization
- **What I did:** Assumed NumPy's primary role was rendering graphics.
- **Why it was wrong:** NumPy is a mathematical array processing library. It has no visualization capabilities natively. OpenCV handles rendering.
- **How I discovered it:** Learned during the explanation of why OpenCV returns NumPy arrays.
- **Correct understanding:** NumPy provides the high-performance memory structure (matrices) needed to process pixels quickly.
- **How to avoid:** Differentiate between data representation (NumPy) and data presentation (OpenCV/Matplotlib).

### 6. Believing FPS should be stored inside every Frame
- **What I did:** Suggested adding `fps: float` to the `Frame` dataclass.
- **Why it was wrong:** FPS is aggregate derived data, while a Frame is a singular instantaneous observation.
- **How I discovered it:** Through applying the "Facts vs. Interpretations" principle.
- **Correct understanding:** Downstream consumers calculate FPS dynamically using the temporal distance between sequential frame timestamps.
- **How to avoid:** Always ask: "Is this a direct observation, or requires historical/computed context?" If computed, it doesn't belong in the observation object.

### 7. PEP 8 Formatting Errors
- **What I did:** Used extra spaces (`class  Frame`), padded equals signs in keyword arguments (`frozen = True`), and omitted spaces in type hints (`image:np.ndarray`).
- **Why it was wrong:** Violates PEP 8, the standard Python style guide, leading to messy and unidiomatic code.
- **How I discovered it:** Corrected during code review.
- **Correct understanding:** `class Frame:`, `frozen=True` (no spaces for kwargs), and `image: np.ndarray` (one space after the colon).
- **How to avoid:** Install and rely on a strict linter/formatter (like `black` or `ruff`) in VS Code to automate PEP 8 compliance.

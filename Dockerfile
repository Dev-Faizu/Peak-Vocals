# ===== Base image =====
FROM python:3.10-slim

# ===== Working directory =====
WORKDIR /app

# ===== Copy project files =====
COPY . /app

# ===== System dependencies =====
# ffmpeg, libsndfile1, libgl1 -> required for audio/ONNX
# git -> for git-based pip installs
# tk, tcl -> optional GUI libs (fixes _tkinter import)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    libgl1 \
    git \
    tk \
    tcl \
    && rm -rf /var/lib/apt/lists/*

# ===== Python setup =====
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# ===== Runtime config =====
ENV PORT=7860
EXPOSE 7860

# ===== Start app =====
CMD ["python", "app.py"]

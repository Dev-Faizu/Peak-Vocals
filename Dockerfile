# ===== Base image =====
FROM python:3.10-slim

# ===== Working directory =====
WORKDIR /app

# ===== Copy project files =====
COPY . /app

# ===== System dependencies =====
# ffmpeg, libsndfile1, libgl1 -> required for audio/ONNX
# git -> required for pip installs from GitHub (e.g., Dora)
# tk, tcl -> fixes tkinter import error
# aria2 -> fixes aria2c not found (model downloader)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    libgl1 \
    git \
    tk \
    tcl \
    aria2 \
    && rm -rf /var/lib/apt/lists/*

# ===== Python setup =====
# Ignore pip root warning
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# ===== Environment configuration =====
ENV PORT=7860
EXPOSE 7860

# ===== Start the app =====
CMD ["python", "app.py"]

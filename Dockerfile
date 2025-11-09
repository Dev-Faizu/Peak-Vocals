# === Base image ===
FROM python:3.10-slim

# === Working directory ===
WORKDIR /app

# === Copy project files ===
COPY . /app

# === Install system dependencies ===
# ffmpeg, libsndfile1, libgl1 -> required by audio and ONNX
# git -> required to install pip packages from GitHub (e.g., Dora)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    libgl1 \
    git \
    && rm -rf /var/lib/apt/lists/*

# === Python setup ===
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# === Environment configuration ===
ENV PORT=7860
EXPOSE 7860

# === Launch the app ===
CMD ["python", "app.py"]

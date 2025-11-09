
FROM python:3.10-slim

WORKDIR /app
COPY . /app

# install system audio libs
RUN apt-get update && apt-get install -y ffmpeg libsndfile1 libgl1 && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

ENV PORT=7860
EXPOSE 7860
CMD ["python", "app.py"]

# VISPER AI: Context-Aware Transcription and Translation System

VISPER offers a powerful two-stage audio processing solution. First, the VISPER Transcription Model, built upon OpenAI's Whisper and enhanced with Librosa signal analysis, generates highly detailed transcriptions with contextual tagging, accurate timestamps, and formatting. Subsequently, the VISPER Translation Model, also leveraging OpenAI's Whisper, takes these precisely transcribed files as input to provide advanced translation between any two languages, preserving the original timestamps and formatting for seamless integration.

---

![VISPER AI](https://github.com/user-attachments/assets/3bc52e9c-5291-4358-829d-f19970701e3a)

---


## Features

- Speech-to-Text Transcription using Whisper.
- Background Sound Detection (e.g., Chorus, OST) using Librosa.
- Timestamped Segmentation of transcribed text.
- Audio Energy Analysis to classify silence, music, and speech.
- Speech Translation to English from multiple source languages.
- Highly Modular and Easy-to-Use Notebooks for both tasks.

---

## Project Structure

```
├── VISPER - Transcription Model (Whisper).ipynb
├── VISPER - Translation Model (Whisper).ipynb
├── requirements.txt
├── Dockerfile
└── README.md
```

---

## Installation

1. **Clone the Repository**
```bash
git clone "https://github.com/SakaethRam/VISPER.git"
cd VISPER
```

2. **Install Dependencies**
```bash
pip install -r requirements.txt
```

3. **Run the Notebooks**
Launch Jupyter Notebook:
```bash
jupyter notebook
```
Open and execute:
- `VISPER - Transcription Model (Whisper).ipynb` for context-rich transcription.
- `VISPER - Translation Model (Whisper).ipynb` for language translation of audio.

---

## Running with Docker

### Build the Docker Image
```bash
docker build -t visper .
```

### Run the Container
```bash
docker run -p 8888:8888 visper
```

Access the notebooks via the link shown in your terminal (e.g., `http://127.0.0.1:8888/?token=...`).

---

## Requirements

- Python 3.8+
- OpenAI Whisper
- Librosa
- NumPy
- IPython
- Google Colab or Local Jupyter

Required packages (in `requirements.txt`):
```
openai-whisper
librosa
numpy
ipython
jupyter
```

---

## Usage Overview

### 1. Transcription Model
- Upload an audio file.
- VISPER transcribes it.
- Audio is analyzed for energy and beat tracking.
- Non-verbal segments are automatically tagged as [Chorus] or [OST].
- Final output is a well-formatted, timestamped transcription.

### 2. Translation Model
- Upload an audio file.
- Choose source language manually (optional if automatic detection).
- Whisper translates the audio content to English.
- Final output is a clean English transcription.

---

## Dockerfile

```dockerfile
# Use an official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install necessary system packages
RUN apt-get update && apt-get install -y git ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Jupyter port
EXPOSE 8888

# Run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
```

---

## Contribution Guidelines

Contributions are welcome. To contribute:
1. Fork the repository.
2. Create a feature branch.
3. Implement your changes.
4. Submit a pull request with a clear description.

---

# License

VISPER AI is distributed under the terms defined in `LICENSE`.

# Setup and Deployment

## Local setup

```bash
git clone https://github.com/SakaethRam/ML-VISPER.git
cd ML-VISPER
pip install -r requirements.txt
jupyter notebook
```

Then open and run either notebook, per `USAGE_GUIDE.md`.

## System requirement: `ffmpeg`

Whisper depends on `ffmpeg` being available on the system path for audio decoding; `pip install -r requirements.txt` installs the Python packages but not `ffmpeg` itself. Install it separately if running outside the provided Docker image:

```bash
# Debian/Ubuntu
sudo apt-get install ffmpeg

# macOS (Homebrew)
brew install ffmpeg
```

The Docker image in this repository already includes `ffmpeg`, so this only matters for a bare local install.

## Docker (CPU)

The repository's existing Dockerfile runs Jupyter with default authentication intact (a token is required to connect), which is the right default for anything reachable beyond localhost:

```bash
docker build -t visper .
docker run -p 8888:8888 visper
```

Access the notebooks via the tokenized link printed in the terminal (`http://127.0.0.1:8888/?token=...`).

## Docker (GPU-accelerated)

Whisper's transcription and translation speed scales significantly with GPU availability, especially on longer audio or larger model sizes. This delivery adds `Dockerfile.gpu` as an optional variant for machines with an NVIDIA GPU and the NVIDIA Container Toolkit installed:

```bash
docker build -f Dockerfile.gpu -t visper-gpu .
docker run --gpus all -p 8888:8888 visper-gpu
```

Requirements for the GPU path:

- An NVIDIA GPU and driver on the host.
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) installed, so `--gpus all` is recognized by the Docker daemon.
- PyTorch installed with CUDA support inside the image (handled by `Dockerfile.gpu`'s base image, rather than the plain `pip install torch` the CPU image uses).

If you're unsure whether the GPU path is worth the setup: it matters most for long audio files or if you're processing many files in sequence. For occasional short clips, the CPU image is simpler and sufficient.

## docker-compose (with dataset volume mount)

```bash
docker compose up --build
```

Mounts `VISPER Datasets/` and a local `output/` directory into the container, so files written or read by the notebooks persist on the host rather than disappearing when the container stops. See `docker-compose.yml`.

## Colab alternative

The README notes Google Colab as a supported environment alongside local Jupyter. If you'd rather not manage local dependencies or GPU drivers at all, uploading the two notebooks to Colab and enabling a GPU runtime there is a reasonable middle ground between the local CPU and local GPU-Docker paths above.

## Deployment checklist

- [ ] `ffmpeg` available (installed separately locally, or via the Docker image)
- [ ] `requirements.txt` installed
- [ ] For GPU use: NVIDIA Container Toolkit installed, `Dockerfile.gpu` built
- [ ] Jupyter token authentication left enabled if the container is reachable beyond localhost
- [ ] `VISPER Datasets/` or your own audio available at a path the notebooks can read

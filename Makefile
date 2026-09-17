.PHONY: install notebook docker-build docker-run docker-gpu-build docker-gpu-run compose-up clean

install:
	pip install -r requirements.txt

notebook:
	jupyter notebook

docker-build:
	docker build -t visper .

docker-run:
	docker run -p 8888:8888 visper

docker-gpu-build:
	docker build -f Dockerfile.gpu -t visper-gpu .

docker-gpu-run:
	docker run --gpus all -p 8888:8888 visper-gpu

compose-up:
	docker compose up --build

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".ipynb_checkpoints" -exec rm -rf {} +

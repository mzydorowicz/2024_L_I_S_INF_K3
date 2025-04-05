deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
run:
	python main.py
.PHONY:test
test:
	PYTHONPATH=. py.test --verbose -s
lint:
	flake8 hello_world test
docker_build:
	docker build -t hello-world-printer .
USERNAME=aleksanderbuczekwsb
DOCKER_PASSWORD=Xewy6Cude9
TAG=$(USERNAME)/hello-world-printer-k3
docker_push: docker_build
	@docker login --username $(USERNAME) --password-stdin $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;
docker_run: docker_build
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

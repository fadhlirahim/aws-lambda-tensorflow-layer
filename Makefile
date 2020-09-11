STACK_NAME ?= tensorflow-layer
S3_LAMBDA_BUCKET ?= s3-lambda-deploy

image:
	make clean
	docker build -t $(STACK_NAME) .

install: #image
	make clean
	docker run --rm -it -v $$PWD:/var/task $(STACK_NAME) make _install

build/packaged.yml: template.yml
	sam package --template-file template.yml --output-template-file packaged.yml --s3-bucket $(S3_LAMBDA_BUCKET)

deploy: build/packaged.yml
	sam deploy --template-file packaged.yml --stack-name $(STACK_NAME) --capabilities CAPABILITY_IAM

clean:
	rm -rf build/layer

# Commands that start with underscore is intended to run *inside* the container.
_install:
	mkdir -p build/layer/python/lib/python3.6/site-packages

	cp -R /build/python/lib/python3.6/site-packages/* ./build/layer/python/lib/python3.6/site-packages
	cd build/layer/python/lib/python3.6/site-packages && \
		pwd && \
		rm -rf external && \
		find . -type d -name "tests" -exec rm -rf {} + && \
		find . -name \*.pyc -delete && \
		find -name "*.so" -not -path "*/PIL/*" | xargs strip && \
		find -name "*.so.*" -not -path "*/PIL/*" | xargs strip && \
		rm -rf *.dist-info && \
		rm -r wheel
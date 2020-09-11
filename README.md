# Tensorflow Lambda Layer

Tensorflow version 1.4.1

## Pre-requisite

You must have AWS IAM access to create role, aws lambda and upload to S3.

Edit `Makefile` and specify value of  `STACK_NAME` and `S3_LAMBDA_BUCKET`


## Step 1: Build docker image

```
make image
```

This command will run docker build with a base image from amazon.

The dockerfile will run `./build.sh` that will install and package all the dependencies to be used in amazon lambda.


## Step 2: Package dependencies for lambda

```
make install
```

This command copies all dependencies in the local `build` folder


## Step 3: Deploy the lambda layer

```
make deploy
```

This command will package the `build/layer` with AWS SAM CLI and upload to S3.

Edit `tempalate.yml` to configure name and compatible runtimes if necessary


## Step 4: Copy the Layer ARN

After a successful deployment, copy the Layer ARN output and paste it in your own lambda app template.yml `Layers` value



## Reference

Dependencies

```
bleach==1.5.0
html5lib==0.9999999
importlib-metadata==1.7.0; python_version < '3.8'
markdown==3.2.2; python_version >= '3.5'
numpy==1.19.2; python_version >= '3.6'
protobuf==3.13.0
six==1.15.0; python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2'
tensorflow-tensorboard==0.4.0
tensorflow==1.4.1
werkzeug==1.0.1; python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3, 3.4'
wheel==0.35.1; python_version >= '3'
zipp==3.1.0; python_version >= '3.6'
```

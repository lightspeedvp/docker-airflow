#!/usr/bin/env bash

ECR_ENDPOINT=073021187591.dkr.ecr.us-west-2.amazonaws.com

aws ecr get-login-password | docker login --username AWS --password-stdin https://${ECR_ENDPOINT}

docker build -t lsvp/airflow .

docker tag lsvp/airflow:latest ${ECR_ENDPOINT}/lsvp/airflow:latest
docker push ${ECR_ENDPOINT}/lsvp/airflow:latest

GIT_HASH="$(git log --pretty=format:"%h" | head -n 1)"
docker tag lsvp/airflow:latest ${ECR_ENDPOINT}/lsvp/airflow:${GIT_HASH}
docker push ${ECR_ENDPOINT}/lsvp/airflow:${GIT_HASH}

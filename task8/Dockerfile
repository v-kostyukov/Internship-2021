FROM python:3.9.6-alpine3.13
ENV PYTHONUNBUFFERED 1
# Creating working directory
RUN mkdir /code
WORKDIR /code
# Copying requirements
COPY ./bravo_django_project/ .
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install -r requirements.txt
#
# Build Docker image:
# $ docker build --tag demosite:v0 .
#
# Run container (from image built above):
# $ docker run -p 8000:8000 demosite:v0
#

FROM python:3-alpine

WORKDIR /app

# install system dependencies
RUN apk update && apk add python3-dev gcc libc-dev postgresql-dev

# install project requirements
COPY demosite/requirements.txt ./
RUN pip install -U pip && pip install -r requirements.txt

COPY demosite/ .
COPY data/pokemon.csv .
COPY docker-entrypoint.sh docker-entrypoint.sh

ENV DEMOSITE_DATA_DIR /app

ARG IN_DOCKER_COMPOSE="False"
ENV IN_DOCKER_COMPOSE=$IN_DOCKER_COMPOSE

RUN python ./manage.py collectstatic --clear --no-input

EXPOSE 8000

ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]

# You could use the same Docker image to run celery, by giving the celery command to your "docker run"
CMD ["gunicorn", "-b", "0.0.0.0:8000", "demosite.wsgi:application"]

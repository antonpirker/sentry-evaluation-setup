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
RUN apk update && apk add python3-dev gcc libc-dev geos

# install project requirements
COPY demosite/requirements.txt ./
RUN pip install -U pip && pip install -r requirements.txt

COPY demosite/ .
COPY data/pokemon.csv .
COPY docker-entrypoint.sh docker-entrypoint.sh

ENV DEMOSITE_DATA_DIR /app

RUN python ./manage.py collectstatic --clear --no-input && python ./manage.py migrate --no-input && python ./manage.py initadmin

EXPOSE 8000

RUN ls -alh /app

ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]

# You could use the same Docker image to run celery, by giving the celery command to your "docker run"
CMD ["gunicorn", "-b", "0.0.0.0:8000", "demosite.wsgi:application"]

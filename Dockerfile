FROM python:3.7-alpine
MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ADD requirements.txt /tmp
RUN apk add -U --virtual .bdep \
    build-base \
    gcc \
    && \
    pip install -r /tmp/requirements.txt && \
    apk del .bdep

ADD . /app
VOLUME /data

WORKDIR /app

EXPOSE 8080

ENV INTERFACE_HOST=0.0.0.0
ENV SMTP_USER=
ENV SMTP_PASSWD=

CMD ./service.py --create_db --refresher --consumer --interface --env

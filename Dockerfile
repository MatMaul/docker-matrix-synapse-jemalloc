FROM python:3.8-slim-buster

RUN apt update \
&&  apt install -y --no-install-recommends ca-certificates libpq5 libffi6 libssl1.1 libxslt1.1 libxml2 libjpeg62-turbo zlib1g libgnutls30 pwgen libldap-2.4-2 libsasl2-2 sqlite xmlsec1 build-essential libjemalloc2 \
&&  pip3 install matrix-synapse==1.10.0rc2 psycopg2-binary matrix-synapse-ldap3 pysaml2 lxml txacme Jinja2 \
&&  apt remove -y build-essential \
&&  apt autoremove -y \
&&  apt clean \
&&  rm -rf /root/.cache/pip/

COPY ./start.py /start.py
COPY ./conf /conf

VOLUME ["/data"]

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libjemalloc.so.2"

ENTRYPOINT ["/start.py"]

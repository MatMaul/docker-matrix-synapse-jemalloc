FROM ubuntu:eoan

RUN apt update
RUN apt install -y --no-install-recommends ca-certificates python3 python3-pip libpq5 libffi6 libssl1.1 libxslt1.1 libxml2 libjpeg-turbo8 zlib1g libgnutls30 pwgen libldap-2.4-2 libsasl2-2 sqlite libjemalloc2
RUN pip3 install --upgrade pip setuptools
RUN pip3 install matrix-synapse==1.10.0rc1 psycopg2-binary matrix-synapse-ldap3 pysaml2 lxml txacme Jinja2
RUN apt clean
RUN rm -rf /root/.cache/pip/

COPY ./start.py /start.py
COPY ./conf /conf

VOLUME ["/data"]

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libjemalloc.so.2"
ENV PYTHONPATH="/usr/local/lib/python3.7/dist-packages"
ENTRYPOINT ["/start.py"]

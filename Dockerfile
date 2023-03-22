ARG RELEASE
FROM openecoe/webui:$RELEASE AS webui
FROM openecoe/api:$RELEASE AS api
FROM nginx
# RUN apt-get update \
#   && apt-get install -y python3 netbase \
#   && rm -rf /var/lib/apt/lists/*
ENV ALEMBIC_UPGRADE=DO

# set environment variables
ENV PYTHONPATH=${PYTHONPATH}:${PWD}
ENV FLASK_APP=openECOE-API.py
ENV FLASK_ENV = production
ENV FLASK_DEBUG = 0

COPY deploy/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=webui /usr/share/nginx/html /usr/share/nginx/html
COPY --from=webui /docker-entrypoint.d/90-envsubst-on-webui.sh /docker-entrypoint.d/90-envsubst-on-webui.sh
#COPY --from=webui /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY --from=api /app/api /app/api
COPY --from=api /venv /venv
ENV PATH="/venv/bin:$PATH"


#COPY --from=api /etc/nginx/conf.d/ecoe-api.conf /etc/nginx/conf.d/ecoe-api.conf
COPY --from=api /docker-entrypoint.d/80-alembic.sh /docker-entrypoint.d/80-alembic.sh
COPY --from=api /docker-entrypoint.d/90-first-run.sh /docker-entrypoint.d/90-first-run.sh
COPY --from=api /docker-entrypoint.d/99-gunicorn.sh /docker-entrypoint.d/99-gunicorn-api.sh

EXPOSE 80
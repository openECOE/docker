ARG RELEASE
FROM openecoe/webui-ng:$RELEASE AS webui
FROM openecoe/api:$RELEASE AS api
FROM openecoe/chrono:$RELEASE AS chrono
FROM nginx
RUN apt-get update \
  && apt-get install -y python3 netbase \
  && rm -rf /var/lib/apt/lists/*
ENV ALEMBIC_UPGRADE=DO

COPY --from=webui /usr/share/nginx/html /usr/share/nginx/html
COPY --from=webui /docker-entrypoint.d/90-envsubst-on-webui.sh /docker-entrypoint.d/90-envsubst-on-webui.sh

COPY --from=api /app/api /app/api
COPY --from=api /etc/nginx/conf.d/ecoe-api.conf /etc/nginx/conf.d/ecoe-api.conf
COPY --from=api /app/api /app/api
COPY --from=api /docker-entrypoint.d/80-alembic.sh /docker-entrypoint.d/80-alembic.sh
COPY --from=api /docker-entrypoint.d/90-first-run.sh /docker-entrypoint.d/90-first-run.sh
COPY --from=api /docker-entrypoint.d/99-gunicorn.sh /docker-entrypoint.d/99-gunicorn-api.sh

COPY --from=chrono /app/chrono /app/chrono
COPY --from=chrono /etc/nginx/conf.d/ecoe-chrono.conf /etc/nginx/conf.d/ecoe-chrono.conf
COPY --from=chrono /docker-entrypoint.d/99-gunicorn.sh /docker-entrypoint.d/99-gunicorn-chrono.sh

EXPOSE 80 1081 1082

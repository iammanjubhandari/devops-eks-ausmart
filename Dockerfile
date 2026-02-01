FROM public.ecr.aws/amazonlinux/amazonlinux:2023

ARG APP_USER=appuser
ARG APP_UID=10001  # Changed from 1000 to avoid conflicts with host users
ARG APP_GID=10001

RUN useradd \
    --home "/app" \
    --create-home \
    --user-group \
    --uid "$APPUID" \
    "$APPUSER"


RUN mkdir -p /app/logs /app/tmp && \
    chown -R ${APP_USER}:${APP_USER} /app && \
    chmod -R 755 /app

WORKDIR /app
USER appuser


COPY ./ATTRIBUTION.md ./LICENSES.md
COPY --chown=appuser:appuser --from=build-env /app.jar .


RUN umask 0027

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
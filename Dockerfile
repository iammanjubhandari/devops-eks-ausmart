# Multi-stage Dockerfile with Optimized Caching

# STAGE 1: Build Stage (Discarded after build)
FROM public.ecr.aws/amazonlinux/amazonlinux:2023 AS build-env

RUN dnf --setopt=install_weak_deps=False install -q -y \
    maven \
    java-21-amazon-corretto-headless \
    && dnf clean all

WORKDIR /workspace

# COPY 1: Dependency files (rarely changes) - CACHED LAYER
COPY pom.xml .
COPY .mvn/ .mvn/
COPY mvnw .

# Download dependencies - CACHED unless pom.xml changes
RUN ./mvnw dependency:go-offline -B -q

# COPY 2: Source code (frequently changes) - SEPARATE LAYER
COPY src/ src/

RUN ./mvnw -DskipTests clean package -q && \
    mv target/*.jar app.jar

# STAGE 2: Package Stage

FROM public.ecr.aws/amazonlinux/amazonlinux:2023

ARG APP_USER=appuser
ARG APP_UID=10001
ARG APP_GID=10001

RUN dnf --setopt=install_weak_deps=False install -q -y \
    java-21-amazon-corretto-headless \
    && dnf clean all

RUN groupadd --gid ${APP_GID} ${APP_USER} && \
    useradd --uid ${APP_UID} \
            --gid ${APP_GID} \
            --shell /bin/bash \
            --create-home \
            ${APP_USER}

RUN mkdir -p /app && \
    chown -R ${APP_USER}:${APP_USER} /app

RUN umask 0027

ENV JAVA_OPTS=""
ENV SPRING_PROFILES_ACTIVE=prod

WORKDIR /app
USER ${APP_USER}

COPY --chown=${APP_USER}:${APP_USER} --from=build-env /workspace/app.jar .


HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
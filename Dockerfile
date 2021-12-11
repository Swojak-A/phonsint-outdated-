FROM python:3.9-slim

# set APP_ENV ('dev'|'stage'|'prod') defult: '' (installs dev requirements, inherited from env)
ARG APP_ENV=${APP_ENV:-dev}

# Tell apt-get we're never going to be able to give manual feedback (on build)
ARG DEBIAN_FRONTEND=noninteractive

# Try to setup proper user IDs
ARG DOCKER_USER_UID=${DOCKER_USER_UID:-998}

# tell python not to buffer stdout
# tell python not to write bytecode to disk
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# os dependencies
RUN apt update && \
    apt install --no-install-recommends -y build-essential binutils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# user
RUN adduser --system --uid=${DOCKER_USER_UID} --group --home=/user/  --shell=/sbin/nologin --gecos "Docker image user" user

# copy scripts
COPY --chown=user:user scripts /user/scripts
RUN chmod ug+x /user/scripts/*

# install requirements
COPY --chown=user:user requirements /user/requirements
RUN  /user/scripts/install-requirements.sh $APP_ENV user

# copy code
COPY --chown=user:user app /user/app/app

USER user

WORKDIR /user/app

CMD ["flask", "run", "--host=0.0.0.0"]

FROM debian:stretch

ARG GROUP_ENV
ARG GROUP_ENV_PLAIN
ARG GROUP_ENV_SPACES

ARG SERVICE_ENV
ARG SERVICE_ENV_SPACES
ARG SERVICE_ENV_PLAIN
ARG withequals

RUN echo $withequals

RUN echo $GROUP_ENV
RUN echo $GROUP_ENV_SPACES
RUN echo $GROUP_ENV_PLAIN

RUN echo $SERVICE_ENV
RUN echo $SERVICE_ENV_SPACES
RUN echo $SERVICE_ENV_PLAIN


RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file . /etc/secrets/secret.file
RUN echo $SECRET_SECRET

WORKDIR /webdis
COPY webdis ./src
COPY webdis-wrapper.sh .
RUN  apt-get update && apt-get -y install wget make gcc libevent-dev \
	&& cd src && make && cp /webdis/src/webdis /webdis/webdis && rm -rf /webdis/src

ENV PATH=/webdis:$PATH

CMD ["/webdis/webdis-wrapper.sh"]
